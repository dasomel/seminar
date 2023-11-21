FROM maven:3.9.5-eclipse-temurin-8-focal as build

# install git, maven
RUN apt-get update && \
    apt-get install -y git

# source download
RUN git clone https://github.com/eGovFramework/egovframe-web-sample.git

# complie -> war
WORKDIR /egovframe-web-sample
RUN mvn package

FROM tomcat:8.5.96-jdk8-temurin-jammy as tomcat
LABEL maintainer="dasomell@gmail.com"
LABEL title="egovframe-web-sample"
LABEL version="4.1.0"
LABEL description="egov sample xml template"

## tomcat deploy
COPY --from=build /egovframe-web-sample/target/template-web-example-1.0.0.war /usr/local/tomcat/webapps/example.war

## tomcat run
EXPOSE 8080
ENTRYPOINT ["catalina.sh", "run"]
