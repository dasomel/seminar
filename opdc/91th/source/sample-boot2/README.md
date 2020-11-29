# 표준프레임워크 샘플 프로젝트
## 1. /k8s/deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: sample-boot2
      labels:
        app: sample-boot2
    spec:
      replicas: 2
      revisionHistoryLimit: 1
      selector:
        matchLabels:
          app: sample-boot2
      template:
        metadata:
          labels:
            app: sample-boot2
        spec:
          containers:
            - name: sample-boot2
              image: localhost:5000/sample-boot2:2.0.0
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
## 2. /k8s/service.yml
    apiVersion: v1
    kind: Service
    metadata:
      name: sample-boot2
    spec:
      selector:
        app: sample-boot2
      ports:
      - port: 8080
        targetPort: 8080
## 3. build & dockerizing
    ./gradlew clean war bootRepackage
    docker build . -t localhost:5000/sample-boot2:2.0.0
    docker push localhost:5000/sample-boot2:2.0.0
## 4. kubernetes build & deploy
    kubectl apply -f ./k8s/deployment.yaml
    kubectl apply -f ./k8s/service.yaml
    kubectl apply -f ./k8s/ingress.yaml
## 5. Confirm
    http://opdc2.io/gradle/egovSampleList.do