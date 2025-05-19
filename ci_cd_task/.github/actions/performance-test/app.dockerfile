# Stage 1: Downloader stage
FROM openjdk:11-slim AS downloader

WORKDIR /tmp

ENV JMETER_VERSION=5.6.3
ENV JMETER_ARCHIVE=apache-jmeter-${JMETER_VERSION}.zip

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://dlcdn.apache.org//jmeter/binaries/${JMETER_ARCHIVE} && \
    unzip ${JMETER_ARCHIVE} && \
    rm ${JMETER_ARCHIVE}

# Stage 2: Runtime stage
FROM openjdk:11-slim

WORKDIR /jmeter

COPY --from=downloader /tmp/apache-jmeter-5.6.3 /jmeter/apache-jmeter-5.6.3

COPY entrypoint.sh /entrypoint.sh
COPY test-plan.jmx /test-plan.jmx

RUN chmod +x /entrypoint.sh

ENV JMETER_HOME=/jmeter/apache-jmeter-5.6.3

ENTRYPOINT ["/entrypoint.sh"]
