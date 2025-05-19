FROM openjdk:11-jre-slim

RUN apt-get update && apt-get install -y wget unzip \
 && wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.zip \
 && unzip apache-jmeter-5.5.zip -d /opt/ \
 && rm apache-jmeter-5.5.zip

ENV JMETER_HOME=/opt/apache-jmeter-5.5
ENV PATH=$JMETER_HOME/bin:$PATH

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
