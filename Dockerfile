Stage 1: Build Jenkins and Apache Tomcat on Ubuntu
FROM ubuntu:latest AS build
RUN apt-get update && apt-get install -y \
    default-jdk \
    wget \
    git \
    maven \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /opt
RUN wget https://get.jenkins.io/war-stable/latest/jenkins.war
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.55/bin/apache-tomcat-9.0.55.tar.gz
RUN tar -xvf apache-tomcat-9.0.55.tar.gz
RUN mv apache-tomcat-9.0.55 tomcat
RUN mv jenkins.war tomcat/webapps/

Stage 2: Copy Jenkins and Apache Tomcat into a new image
FROM ubuntu:latest
RUN apt-get update && apt-get install -y \
    default-jdk \
    && rm -rf /var/lib/apt/lists/*
    
COPY --from=build /opt/tomcat /opt/tomcat
EXPOSE 80
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
