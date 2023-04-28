FROM ubuntu:latest AS stage1 
RUN apt update
RUN apt-get install -y wget openjdk-11-jdk
RUN wget https://get.jenkins.io/war-stable/2.387.2/jenkins.war 
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.74/bin/apache-tomcat-9.0.74.tar.gz
RUN tar -zxvf apache-tomcat-9.0.74.tar.gz
RUN cp jenkins.war apache-tomcat-9.0.74/webapps/
RUN apt-get install -y apache2 

FROM ubuntu:latest
WORKDIR /home/ubuntu
RUN apt-get update && apt-get install -y openjdk-11-jdk 
COPY --from=stage1 apache-tomcat-9.0.74 .
EXPOSE 8080
COPY --from=stage1 /etc/apache2 /etc/apache2
EXPOSE 80
CMD ["/bin/catalina.sh", "run"]
