FROM openjdk:8-jre-alpine
LABEL maintainer=<dasomell@gmail.com>
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo Asia/Seoul > /etc/timezone

COPY ./build/libs/sample-boot2.war app.war
ENTRYPOINT ["java","-server","-D64","-Djava.security.egd=file:./dev/urandom","-jar","/app.war"]
EXPOSE 8080