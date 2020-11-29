# 표준프레임워크 샘플 프로젝트
## 1. Complie & package
##### mvn clean package

## 2. Dockerfile & Dockerizing
##### docker build . -t localhost:5000/egov-sample:1.0.0
    FROM tomcat:9.0.39-jdk8-openjdk-buster
    LABEL maintainer=<dasomell@gmail.com>
    
    # WORKDIR /usr/local/tomcat
    ADD ./target/sample-1.0.0.war /usr/local/tomcat/webapps/war.war
    
    EXPOSE 8080
    
## 3. push & Confirm
##### docker push localhost:5000/egov-sample:1.0.0
##### curl -X GET http://localhost:5000/v2/egov-sample/tags/list
    
## 4. Kubernetes deploy
##### kubectl apply -f ./k8s/deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: egov-sample
      labels:
        app: egov-sample
    spec:
      replicas: 1
      revisionHistoryLimit: 1
      selector:
        matchLabels:
          app: egov-sample
      template:
        metadata:
          labels:
            app: egov-sample
        spec:
          containers:
            - name: egov-sample
              image: localhost:5000/egov-sample:1.0.0
              ports:
                - containerPort: 8080
              imagePullPolicy: Always
              resources:
                requests:
                  cpu: 0.5
                  memory: 0.5Gi
                limits:
                  cpu: 0.5
                  memory: 0.5Gi
## 5. Kubernetes service
##### kubectl apply -f ./k8s/service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: egov-sample
    spec:
      selector:
        app: egov-sample
      ports:
      - port: 8080
        targetPort: 8080

## 6. Kubernetes ingress
##### kubectl apply -f ./k8s/ingress.yaml
    apiVersion: networking.k8s.io/v1beta1
    kind: Ingress
    metadata:
      name: opdc-ingress
    spec:
      rules:
        - host: opdc.io
          http:
            paths:
              - path: /war
                backend:
                  serviceName: egov-sample
                  servicePort: 8080
              - path: /maven
                backend:
                  serviceName: sample-boot
                  servicePort: 8080
        - host: opdc2.io
          http:
            paths:
              - path: /gradle
                backend:
                  serviceName: sample-boot2
                  servicePort: 8080

## 7. Confirm
   http://opdc.io/maven/egovSampleList.do