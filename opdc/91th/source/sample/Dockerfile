FROM tomcat:9.0.39-jdk8-openjdk-buster
LABEL maintainer=<dasomell@gmail.com>

# WORKDIR /usr/local/tomcat
ADD ./target/sample-1.0.0.war /usr/local/tomcat/webapps/war.war

EXPOSE 8080