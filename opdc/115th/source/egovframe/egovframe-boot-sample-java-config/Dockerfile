FROM maven:3.9.5-eclipse-temurin-8-focal as build

# install git, maven
RUN apt-get update && \
    apt-get install -y git

# source download
RUN git clone https://github.com/eGovFramework/egovframe-boot-sample-java-config.git

WORKDIR /egovframe-boot-sample-java-config

# source compile
RUN mvn package spring-boot:repackage

EXPOSE 8080
ENTRYPOINT ["mvn", "spring-boot:run"]
