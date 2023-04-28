# Build stage
FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y openjdk-11-jdk
RUN apt-get install -y wget && \
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - && \
    echo 'deb https://pkg.jenkins.io/debian-stable binary/' >> /etc/apt/sources.list.d/jenkins.list && \
    apt-get update && \
    apt-get install -y jenkins

# Production stage
FROM ubuntu:latest

RUN apt-get update && apt-get install -y apache2

COPY --from=build /etc/apt/sources.list.d/jenkins.list /etc/apt/sources.list.d/jenkins.list
COPY --from=build /usr/share/jenkins/jenkins.war /usr/share/jenkins/jenkins.war

RUN apt-get update && apt-get install -y openjdk-11-jdk jenkins

EXPOSE 8080

CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
