# .github/actions/performance-test/app.dockerfile
FROM openjdk:11-jre-slim

RUN apt-get update && apt-get install -y wget unzip && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.zip -O /tmp/jmeter.zip && \
    unzip /tmp/jmeter.zip -d /opt && \
    rm /tmp/jmeter.zip

ENV JMETER_HOME=/opt/apache-jmeter-5.5
ENV PATH="$JMETER_HOME/bin:$PATH"

WORKDIR /jmeter

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
