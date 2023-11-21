#!/usr/bin/env bash

# container build
docker build . -t 192.168.100.100:30002/cp-portal-repository/egovframe-web-sample:4.1.0

# Harbor(container registry) login
docker login 192.168.100.100:30002 -u admin -p Harbor12345

# Harbor(container registry) image push
docker push 192.168.100.100:30002/cp-portal-repository/egovframe-web-sample:4.1.0

# local container run
docker run -it --rm -p 8080:8080 192.168.100.100:30002/cp-portal-repository/egovframe-web-sample:4.1.0

# local container shell
docker run -it 192.168.100.100:30002/cp-portal-repository/egovframe-web-sample:4.1.0 /bin/sh

# Harbor(container registry) secret
kubectl create secret docker-registry egovregistrykey \
  --docker-server=192.168.100.100:30002 \
  --docker-username=admin --docker-password=Harbor12345

# K-PaaS container dcploy
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
