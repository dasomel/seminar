#!/usr/bin/env bash
set -euo pipefail

echo "===== Namespaces (ambient/waypoint labels) ====="
kubectl get ns -L istio.io/dataplane-mode,istio.io/use-waypoint

echo
echo "===== Pods in ns-test ====="
kubectl get pods -n ns-test -o wide

echo
echo "===== Istio Ingress Gateway Service ====="
kubectl get svc -n istio-system istio-gateway-istio

echo
echo "===== Gateways ====="
kubectl get gateway -n istio-system,ns-test

echo
echo "===== HTTPRoutes in ns-test ====="
kubectl get httproute -n ns-test

echo
echo "===== Describe Shared Gateway ====="
kubectl describe gateway istio-gateway -n istio-system

echo
echo "===== Describe Shared HTTPRoute ====="
kubectl describe httproute web-test-httproute-shared -n ns-test || true

echo
echo "===== Describe Waypoint Gateway ====="
kubectl describe gateway web-test-waypoint -n ns-test

echo
echo "===== Describe Waypoint HTTPRoute ====="
kubectl describe httproute web-test-httproute-shared -n ns-test

echo
echo "===== Envoy Logs (Ingress Gateway) ====="
ING_POD=$(kubectl get pods -n istio-system -l app=istio-ingress -o jsonpath='{.items[0].metadata.name}')
kubectl logs -n istio-system "$ING_POD" -c istio-proxy --tail=100 || echo "No ingress-gateway pod found"

echo
echo "===== Envoy Logs (Waypoint) ====="
WP_POD=$(kubectl get pods -n ns-test -l gateway.networking.k8s.io/gateway-name=web-test-waypoint -o jsonpath='{.items[0].metadata.name}')
kubectl logs -n ns-test "$WP_POD" -c istio-proxy --tail=100

echo
echo "===== NetworkPolicy & CiliumNetworkPolicy ====="
kubectl get networkpolicy -n ns-test
kubectl get ciliumnetworkpolicy -n ns-test
