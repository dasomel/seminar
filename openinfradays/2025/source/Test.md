# 구성 요약

이 구성은 Istio Ambient(ztunnel + Waypoint)와 Kubernetes Gateway API, 그리고 Cilium L7/FQDN 네트워크 정책을 함께 사용해 L4/L7 보안과 트래픽 제어를 구현합니다. 외부 트래픽은 Istio Ingress Gateway(Gateway/HTTPRoute)로 들어오고, 클러스터 내부로는 Ambient의 HBONE(mTLS) 경로를 통해 Waypoint(Envoy L7 프록시)를 거쳐 서비스로 라우팅됩니다. Cilium 정책으로는 파드 앞단 L7 허용(HTTP GET “/”만 허용)과 egress FQDN(https://httpbin.org만 허용)을 추가로 적용합니다.

***

## 파일별 설명

### 1) namespace.yaml
- ns-test 네임스페이스 생성.
- 라벨:
    - istio.io/dataplane-mode: ambient → 해당 네임스페이스 파드가 ztunnel을 통한 Ambient 데이터플레인에 자동 편입.
    - istio.io/use-waypoint: web-test-waypoint → 해당 네임스페이스의 트래픽을 Waypoint(Envoy L7 프록시)로 보내 L7 정책/라우팅 적용.

### 2) waypoint.yaml
- kind: Gateway, gatewayClassName: istio-waypoint[test2.md](test2.md)
- ns-test 안에 “web-test-waypoint” Waypoint(Envoy)를 배치, 포트 15008(HBONE) 리스너를 노출.
- 네임스페이스 라벨과 합쳐서 ns-test 내 워크로드의 L7 정책 집행 지점이 됩니다.

### 3) waypoint-authz.yaml
- AuthorizationPolicy(targetRefs = Service:web-test-service)
- Waypoint에서 서비스 단위 L7 인가: HTTP 메서드 “GET”만 허용.
- 즉, Waypoint 레벨에서 POST/PUT 등은 거부됩니다.

### 4) cluster-policy.yaml (Kyverno)
- Waypoint(관리형 Gateway) 파드에 보안 하드닝 강제:
    - Pod-level seccompProfile=RuntimeDefault, runAsNonRoot=true
    - istio-proxy 컨테이너에 allowPrivilegeEscalation=false, capabilities drop ALL, seccompProfile=RuntimeDefault
- match 기준: gateway.networking.k8s.io/gateway-name: web-test-waypoint 라벨을 가진 파드(=Waypoint 파드).

### 5) peer-authentication.yaml
- ns-test 네임스페이스에 PeerAuthentication STRICT
- Ambient 구간에서 mTLS(STRICT) 강제. Waypoint/HBONE/ztunnel 경로만 허용되며, 평문 직접 통신은 차단됩니다.

### 6) network-policy.yaml (Kubernetes NetworkPolicy)
- allow-from-istio-system: ns-test/web-test 파드로의 Ingress를 istio-system 네임스페이스에서 오는 트래픽만 8080 포트로 허용.
- allow-ztunnel: ns-test/web-test 파드의 Ingress/Egress 모두 istio-system 네임스페이스(ztunnel/ingress 등)와 통신 허용.
- allow-dns: Egress로 TCP/UDP 53 허용(DNS 질의 허용).
- 결과적으로, 외부에서 NodePort 등으로 직접 접근은 차단되고, Istio Ingress/ztunnel 경유 트래픽만 통과합니다.

### 7) cilium-network-policy.yaml (CiliumNetworkPolicy)
- web-test-l7-ingress:
    - 파드 포트 8080에 대한 HTTP L7 정책: GET “/” 경로만 허용(path: “^/$”).
    - GET /foo, POST / 등은 Cilium L7 레벨에서 차단됩니다.
- web-test-egress-fqdn:
    - DNS(53) 허용.
    - Egress는 https://httpbin.org:443로만 허용(FQDN 정책). 그 외 외부 도메인은 차단.

### 8) deployment.yaml
- ns-test에 nginxinc/nginx-unprivileged:latest 컨테이너(비루트)로 web-test 배포.
- 컨테이너 포트 8080 사용(nginx-unprivileged 기본 포트).
- 파드/네임스페이스 라벨로 Ambient 명시(네임스페이스 라벨만으로도 동작하지만 유지).

### 9) service.yaml
- web-test-service(Service, NodePort 30000 → targetPort 8080)
- 내부 라우팅은 ClusterIP만으로 충분하지만, 여기서는 NodePort 값이 지정되어 있음.
- 단, NetworkPolicy로 인해 외부에서 NodeIP:30000 직접 접근은 차단됩니다(istio-system에서 오는 트래픽만 허용).

### 10) gateway.yaml
- istio-system 네임스페이스에 Istio Ingress Gateway(Gateway API) 리스너 설정(HTTP/80, hostname: test.test).
- gatewayClassName: istio → Istio Gateway 컨트롤러가 관리하는 인그레스 게이트웨이.

### 11) http-route.yaml
- ns-test에 HTTPRoute 생성, parentRefs로 istio-system/istio-gateway에 연결.
- hostnames: test.test, PathPrefix “/”를 web-test-service:80으로 라우팅.
- 외부 → Ingress Gateway → HTTPRoute → Service → Ambient(HBONE/mTLS) → Waypoint(L7 인가) → 파드

***

## 전체 트래픽 흐름

- 외부 클라이언트 → Istio Ingress Gateway(HTTP/80, Host: test.test) → HTTPRoute(web-test-service) → Ambient 경로(HBONE, mTLS STRICT)로 Waypoint(Envoy) 통과 → Cilium L7 정책과 Waypoint AuthorizationPolicy 적용 → nginx 파드(8080) 도착.
- Egress는 파드에서 외부로 나갈 때 Cilium FQDN 정책에 의해 httpbin.org:443만 허용.

***

## 배포 순서와 적용 명령

순서는 “네임스페이스/컨트롤면 리소스 → 데이터면 리소스 → 정책 → 애플리케이션” 순으로 적용하면 안정적입니다.

```bash
# 0) 사전: Istio Ambient(ztunnel/waypoint 지원)와 Istio Ingress Gateway, Cilium이 정상 동작 중이어야 합니다.
#    (istio-system에 ztunnel/ingress, cilium status OK 등)

# 1) 네임스페이스/Waypoint/하드닝 규칙
kubectl apply -f namespace.yaml
kubectl apply -f waypoint.yaml
kubectl apply -f cluster-policy.yaml

# 2) 인그레스(Gateway/HTTPRoute)
kubectl apply -n istio-system -f gateway.yaml
kubectl apply -n ns-test -f http-route.yaml

# 3) 보안 정책(Istio/Cilium/K8s)
kubectl apply -n ns-test -f peer-authentication.yaml
kubectl apply -n ns-test -f network-policy.yaml
kubectl apply -n ns-test -f cilium-network-policy.yaml
kubectl apply -n ns-test -f waypoint-authz.yaml

# 4) 앱 배포(Service/Deployment)
kubectl apply -n ns-test -f service.yaml
kubectl apply -n ns-test -f deployment.yaml
```

검증(상태 확인):

```bash
# Waypoint, Gateway, HTTPRoute 상태
kubectl get gateway -A
kubectl get httproute -A
kubectl -n ns-test get gateway web-test-waypoint -o yaml | sed -n '1,120p'

# Ambient 적용/Waypoint 연결 확인
kubectl -n ns-test get pods -l app=web-test -o wide
kubectl -n ns-test get pod -l app=web-test -o jsonpath='{.items[0].metadata.labels}{"\n"}'

# 정책 적용 확인
kubectl -n ns-test get peerauthentication
kubectl -n ns-test get networkpolicy
kubectl -n ns-test get ciliumnetworkpolicy
kubectl -n ns-test get authorizationpolicy
```

***

## 외부 접근 테스트

사전 준비:
- Ingress Gateway의 외부 접속점 확인: LoadBalancer IP 또는 NodePort.
- 호스트 헤더가 test.test로 매칭되어야 하므로, 두 가지 중 하나를 사용:
    - /etc/hosts에 “<INGRESS_IP> test.test” 추가, 또는
    - curl 시 -H "Host: test.test" 사용.

예시(LoadBalancer가 있다고 가정):

```bash
INGRESS_IP=$(kubectl -n istio-system get svc -l gateway.networking.k8s.io/gateway-name=istio-gateway -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}')
# 만약 NodePort 사용 시: NODE_IP=<노드IP>; INGRESS_PORT=<ingress svc의 NodePort>; URL은 http://$NODE_IP:$INGRESS_PORT

# 1) 허용 케이스: GET / (기대: 200 OK (nginx 기본 페이지))
curl -i -H "Host: test.test" http://$INGRESS_IP/

# 2) 거부 케이스: POST / (기대: 403/차단 (Waypoint AuthorizationPolicy가 GET만 허용, Cilium도 POST 차단))
curl -i -X POST -H "Host: test.test" http://$INGRESS_IP/

# 3) 거부 케이스: GET /foo (기대: 403/차단 (Cilium L7 정책이 path "^/$" 외에는 거부))
curl -i -H "Host: test.test" http://$INGRESS_IP/foo

```

주의:
- service.yaml에 NodePort:30000이 있으나, Kubernetes NetworkPolicy(allow-from-istio-system) 때문에 외부에서 NodeIP:30000으로 바로 접속해도 “istio-system 네임스페이스에서 온 트래픽”이 아니므로 차단됩니다.
- 반드시 Ingress Gateway를 통해 접근하여 동작을 확인하세요.

***

## 파드 내부 egress 테스트
- Cilium FQDN 정책으로 httpbin.org:443만 허용되었는지 확인합니다.

```bash
# 디버그 파드 실행
kubectl -n ns-test run curl \
  --image=curlimages/curl:8.9.1 \
  --restart=Never -it --rm \
  --overrides='{
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": { "name": "curl" },
    "spec": {
      "securityContext": {
        "runAsNonRoot": true,
        "runAsUser": 1000,
        "seccompProfile": { "type": "RuntimeDefault" }
      },
      "containers": [
        {
          "name": "curl",
          "image": "curlimages/curl:8.9.1",
          "stdin": true,
          "tty": true,
          "command": ["/bin/sh"],
          "securityContext": {
            "allowPrivilegeEscalation": false,
            "capabilities": { "drop": ["ALL"] }
          }
        }
      ]
    }
  }'
````

### 파드(curl) 안에서 아래 실행
```shell
# 1) 허용 케이스: https://httpbin.org/get (기대: 200 OK)
curl -I https://httpbin.org/get

# 2) 거부 케이스: https://example.com (기대: 연결 실패 또는 차단 (Cilium FQDN 정책))
curl -I https://example.com

```

- DNS 정책도 함께 적용되어 있으므로 도메인 해석은 정상이어야 하지만, 53 포트만 열려 있고 실제 egress HTTP/HTTPS는 httpbin.org:443만 허용됩니다.

***

## mTLS(STRICT) 및 경로 검증 포인트

- PeerAuthentication STRICT로 ns-test 워크로드 간 통신은 Ambient(HBONE) mTLS 경로만 허용됩니다.
- 외부 → Ingress → 내부로 들어온 트래픽은 Waypoint를 경유하며, Waypoint–워크로드 간은 HBONE mTLS로 보호됩니다.
- 직접 파드 IP:8080으로 접근하는 시도는 K8s NetworkPolicy에서 먼저 차단되므로, 실제 유효 경로는 Ingress → Waypoint → 파드 뿐입니다.
- 추가 검증 팁:
    - Ingress에서 정상 응답(200)이 나오면서 동일 요청이 NodePort/직접 파드 IP로는 차단되는지 확인(Policy 유효성).
    - Waypoint/ztunnel 로그 또는 Hubble(설치 시)로 “L7 Allowed/Denied”, “mTLS” 여부를 관찰.

***

## 흔한 이슈와 점검 체크리스트

- Hostname 불일치: Gateway/HTTPRoute 모두 hostnames: test.test로 설정됨. curl 시 Host 헤더를 반드시 맞추기.
- Ingress 진입점: Ingress Service의 외부 IP/포트 확인 필요. LB 미구성 환경은 NodePort로 동작 여부 파악.
- Waypoint 연결: 네임스페이스 라벨 istio.io/use-waypoint와 Waypoint 이름 일치 확인(web-test-waypoint).
- 포트 매핑: nginx는 8080, Service targetPort 8080, HTTPRoute backendRefs port 80(=Service Port) 일치 확인.
- Cilium L7 프록시: Cilium이 L7 정책을 적용할 수 있는 상태인지(cilium status)와 kube-proxy 모드/정책 엔진 활성화 확인.
- Kyverno 권한: ClusterPolicy가 Waypoint 파드를 정상 변이(mutate)했는지 파드 보안 컨텍스트 확인.
- DNS: allow-dns(Cilium/K8s) 정책이 있어야 FQDN 정책이 정상 동작합니다.

***

## 정리: 기대 동작

- 외부에서 GET / 요청은 200 OK.
- 외부에서 POST / 또는 GET /foo 요청은 403/차단(Cilium L7 + Waypoint AuthZ).
- 파드 egress는 httpbin.org:443만 허용, 그 외 도메인은 차단.
- 직접 NodePort(30000) 또는 파드 IP 접근은 K8s NetworkPolicy로 차단.
- 내부 경로는 Ambient HBONE mTLS로 보호되며, Waypoint에서 메서드 기반 인가가 추가로 적용.
