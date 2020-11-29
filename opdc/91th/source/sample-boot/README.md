# 표준프레임워크 샘플 프로젝트
## 1. kubernetes-maven-plugin 설정(pom.xml)
    <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
    </plugin>
    <plugin>
        <groupId>org.eclipse.jkube</groupId>
        <artifactId>kubernetes-maven-plugin</artifactId>
        <version>1.0.2</version>
        <configuration>
            <images>
                <image>
                    <name>localhost:5000/sample-boot:${timestamp}</name>
                    <build>
                        <from>fabric8/java-centos-openjdk8-jre</from>
                        <maintainer>dasomell@gmail.com</maintainer>
                        <assembly>
                            <inline>
                                <baseDirectory>/deployments</baseDirectory>
                            </inline>
                            <mode>dir</mode>
                            <targetDir>/deployments</targetDir>
                        </assembly>
                        <env>
                            <JAVA_LIB_DIR>/deployments</JAVA_LIB_DIR>
                            <CATALINA_OPTS>-Djava.security.egd=file:/dev/urandom</CATALINA_OPTS>
                        </env>
                    </build>
                </image>
            </images>
        </configuration>
        <executions>
            <execution>
                <id>jkube</id>
                <goals>
                    <goal>resource</goal>
                    <goal>build</goal>
                    <goal>push</goal>
                    <goal>deploy</goal>
                </goals>
            </execution>
        </executions>
    </plugin>
## 2. /src/main/jkube/deployment.yml
    spec:
      template:
        spec:
          containers:
            - resources:
                limits:
                  cpu: 500m
                  memory: 500Mi
                requests:
                  cpu: 500m
                  memory: 500Mi
          
## 2. /src/main/jkube/service.yml
    apiVersion: v1
    kind: Service
    metadata:
      name: sample-boot
    spec:
      selector:
        app: sample-boot
      ports:
      - port: 8080
        targetPort: 8080
          
## 3. build & deploy 
    mvn clean package spring-boot:repackage k8s:build k8s:resource k8s:push k8s:apply
## 4. Confirm
   http://opdc.io/maven/egovSampleList.do