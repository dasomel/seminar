# Kubernetes 설치 및 관리 프로젝트

이 프로젝트는 Kubernetes 클러스터를 손쉽게 설치하고 관리하기 위한 자동화된 스크립트와 설정 파일을 제공합니다.  
VM 환경에서 Kubernetes를 설치하고, 네트워크 및 보안 정책을 구성하며, 다양한 테스트 환경을 배포할 수 있습니다.

## 목차
1. [프로젝트 개요](#프로젝트-개요)
2. [환경 준비](#환경-준비)
3. [Kubernetes 설치](#kubernetes-설치)
4. [문제 해결](#문제-해결)

## 1. 프로젝트 개요
- **목적**: Kubernetes 클러스터 설치 및 관리 자동화
- **주요 기능**:
    - VM 생성 및 관리
    - Kubernetes 설치 및 네트워크 구성
    - Helm을 통한 애플리케이션 배포
    - 네트워크 및 보안 정책 테스트

## 2. 환경 준비
### VirtualBox 및 Vagrant 설치
```shell
# Install Vagrant
brew install vagrant
brew install --cask virtualbox
vagrant plugin install vagrant-vbguest
```

## VM
```shell
vagrant up --provision   # VM 생성
vagrant destroy -f       # VM 삭제
vagrant status           # VM 상태 확인
vagrant ssh master1      # 마스터 노드 접속
vagrant ssh worker1      # 워커 노드 접속
```

## 3. Kubernetes 설치 및 배포

- 글로벌 변수 및 환경설정: `scripts/00.global_variable.sh`, `scripts/set-config.sh`
- 마스터/워커/네트워크/Helm 등 자동화 스크립트: `scripts/01.all_common_setting.sh` 등
- 네트워크/모니터링/보안 정책: `network/`, `helm/` 내 YAML 파일 참고
- 테스트 환경 배포: `test/`kustomize build ./test | kubectl apply -f -

## VM IP 확인
```shell
vagrant ssh master1 -c "hostname -I | awk '{print $1}'"
```

## 4. Trouble Shutting

### 4.1 서버 재기동시 RKE2 Server 기동이 안되는 현상
- Error log
~~~
Aug 14 21:07:55 master01 systemd[1]: Failed to start rke2-server.service - Rancher Kubernetes Engine v2 (server).
Aug 14 21:08:00 master01 systemd[1]: rke2-server.service: Scheduled restart job, restart counter is at 105.
Aug 14 21:08:00 master01 sh[4735]: + /usr/bin/systemctl is-enabled --quiet nm-cloud-setup.service
Aug 14 21:08:00 master01 systemd[1]: Starting rke2-server.service - Rancher Kubernetes Engine v2 (server)...
Aug 14 21:08:00 master01 rke2[4741]: time="2025-08-14T21:08:00+09:00" level=info msg="Applying Pod Security Admission Configuration"
Aug 14 21:08:00 master01 rke2[4741]: time="2025-08-14T21:08:00+09:00" level=info msg="Starting rke2 v1.32.7+rke2r1 (43f78039de70d99974d298c344595f45c2c47731)"
Aug 14 21:08:00 master01 rke2[4741]: time="2025-08-14T21:08:00+09:00" level=info msg="Managed etcd cluster bootstrap already complete and initialized"
Aug 14 21:08:00 master01 rke2[4741]: time="2025-08-14T21:08:00+09:00" level=info msg="Starting temporary etcd to reconcile with datastore"
Aug 14 21:08:00 master01 rke2[4741]: {"level":"info","ts":"2025-08-14T21:08:00.685065+0900","caller":"embed/etcd.go:134","msg":"configuring socket options","reuse-address":true,"reuse-port":true}
Aug 14 21:08:00 master01 rke2[4741]: {"level":"info","ts":"2025-08-14T21:08:00.685251+0900","caller":"embed/etcd.go:140","msg":"configuring peer listeners","listen-peer-urls":["https://192.168.33.11:2380"]}
Aug 14 21:08:00 master01 rke2[4741]: {"level":"error","ts":"2025-08-14T21:08:00.685316+0900","caller":"embed/etcd.go:570","msg":"creating peer listener failed","error":"cannot listen on TLS for 192.168.33.11:2380: KeyFile and CertFile are not presented","stacktrace":"go.etcd.io/etcd/server/v3/embed.configurePeerListeners\n\t/go/pkg/mod/github.com/k3s-io/etcd/server/v3@v3.5.21-k3s1/embed/etcd.go:570\ngo.etcd.io/etcd/server/v3/embed.StartEtcd\n\t/go/pkg/mod/github.com/k3s-io/etcd/server/v3@v3.5.21-k3s1/embed/etcd.go:144\ngithub.com/k3s-io/k3s/pkg/daemons/executor.(*Embedded).ETCD\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/daemons/executor/etcd.go:64\ngithub.com/k3s-io/k3s/pkg/etcd.(*ETCD).StartEmbeddedTemporary\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/etcd/etcd.go:1095\ngithub.com/k3s-io/k3s/pkg/cluster.(*Cluster).reconcileEtcd\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/cluster/bootstrap.go:559\ngithub.com/k3s-io/k3s/pkg/cluster.(*Cluster).Bootstrap\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/cluster/bootstrap.go:70\ngithub.com/k3s-io/k3s/pkg/daemons/control.prepare\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/daemons/control/server.go:323\ngithub.com/k3s-io/k3s/pkg/daemons/control.Prepare\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/daemons/control/server.go:46\ngithub.com/k3s-io/k3s/pkg/server.PrepareServer\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/server/server.go:59\ngithub.com/k3s-io/k3s/pkg/cli/server.run\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/cli/server/server.go:516\ngithub.com/k3s-io/k3s/pkg/cli/server.RunWithControllers\n\t/go/pkg/mod/github.com/k3s-io/k3s@v1.32.7-0.20250715012423-a00164a4dd73/pkg/cli/server/server.go:51\ngithub.com/rancher/rke2/pkg/rke2.Server\n\t/source/pkg/rke2/rke2.go:135\ngithub.com/rancher/rke2/pkg/cli/cmds.ServerRun\n\t/source/pkg/cli/cmds/server.go:194\ngithub.com/urfave/cli/v2.(*Command).Run\n\t/go/pkg/mod/github.com/urfave/cli/v2@v2.27.7/command.go:276\ngithub.com/urfave/cli/v2.(*Command).Run\n\t/go/pkg/mod/github.com/urfave/cli/v2@v2.27.7/command.go:269\ngithub.com/urfave/cli/v2.(*App).RunContext\n\t/go/pkg/mod/github.com/urfave/cli/v2@v2.27.7/app.go:333\ngithub.com/urfave/cli/v2.(*App).Run\n\t/go/pkg/mod/github.com/urfave/cli/v2@v2.27.7/app.go:307\nmain.main\n\t/source/main.go:24\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:272"}
Aug 14 21:08:00 master01 rke2[4741]: {"level":"info","ts":"2025-08-14T21:08:00.685392+0900","caller":"embed/etcd.go:408","msg":"closing etcd server","name":"master01-0823c5c8","data-dir":"/var/lib/rancher/rke2/server/db/etcd-tmp","advertise-peer-urls":["https://192.168.33.11:2380"],"advertise-client-urls":["https://192.168.33.11:2379"]}
Aug 14 21:08:00 master01 rke2[4741]: {"level":"info","ts":"2025-08-14T21:08:00.685396+0900","caller":"embed/etcd.go:410","msg":"closed etcd server","name":"master01-0823c5c8","data-dir":"/var/lib/rancher/rke2/server/db/etcd-tmp","advertise-peer-urls":["https://192.168.33.11:2380"],"advertise-client-urls":["https://192.168.33.11:2379"]}
Aug 14 21:08:00 master01 rke2[4741]: time="2025-08-14T21:08:00+09:00" level=fatal msg="Failed to reconcile with temporary etcd: cannot listen on TLS for 192.168.33.11:2380: KeyFile and CertFile are not presented"
Aug 14 21:08:00 master01 systemd[1]: rke2-server.service: Main process exited, code=exited, status=1/FAILURE
Aug 14 21:08:00 master01 systemd[1]: rke2-server.service: Failed with result 'exit-code'.
Aug 14 21:08:00 master01 systemd[1]: Failed to start rke2-server.service - Rancher Kubernetes Engine v2 (server).
~~~

- 해결책(아래 etcd-arg 아래 4개 주석처리)
~~~
sudo vi /etc/rancher/rke2/config.yaml
etcd-arg:
  - "listen-peer-urls=https://${NODE_IP}:2380"
  - "listen-client-urls=https://${NODE_IP}:2379,https://127.0.0.1:2379"
  - "advertise-client-urls=https://${NODE_IP}:2379"
  - "initial-advertise-peer-urls=https://${NODE_IP}:2380"
~~~

---

### 4.2 VirtualBox 기동 실퍠
- Error log
~~~
~/.vagrant.d/gems/3.3.8/gems/vagrant-vbguest-0.32.0/lib/vagrant-vbguest/hosts/virtualbox.rb:84:in `block in guess_local_iso': undefined method `exists?' for class File (NoMethodError)

            path && File.exists?(path)
                        ^^^^^^^^
Did you mean?  exist?
~~~
- 증상: vagrant up 등 실행 시 Ruby File.exists? 관련 에러 발생
- 원인: Ruby 3.x 이상에서 File.exists?가 File.exist?로 변경됨
- 해결책:
  1. 에러 난 파일 위치 확인 (예: ~/.vagrant.d/gems/3.3.8/gems/vagrant-vbguest-0.32.0/lib/vagrant-vbguest/hosts/virtualbox.rb)
  2. 텍스트 에디터로 열어 File.exists?(path) 구문을 File.exist?(path)로 변경

### 4.3 istio-ingress Helm 배포 실패
~~~
helm upgrade --install istio-ingress istio/gateway --version 1.27.0 -f ./scripts/helm/istio-gateway-1.27.0.yaml -n istio-system --wait
Release "istio-ingress" does not exist. Installing it now.
Error: values don't meet the specifications of the schema(s) in the following chart(s):
gateway:
- at '': additional properties '_internal_defaults_do_not_set' not allowed
~~~

- 해결책:
- --skip-schema-validation 지원이 Helm에 추가되었고(설치/업그레이드/렌더링 등에서 스키마를 무시)
- 이 플래그로 values.schema.json 검증을 비활성화
  1. Helm 3.12+ 버전에서 --skip-schema-validation 플래그 사용
  2. 아래 명령어로 values.schema.json 검증을 비활성화하여 배포

```shell
helm upgrade --install istio-ingress istio/gateway \
  --version 1.27.0 \
  -n istio-system --wait \
  -f ./source/helm/istio-gateway-1.27.0.yaml \
  --skip-schema-validation
```
