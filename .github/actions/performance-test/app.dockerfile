FROM openjdk:11-jre-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Install JMeter (use --fail for curl to ensure proper download checks)
RUN curl -L --fail https://downloads.apache.org/jmeter/binaries/apache-jmeter-5.5.tgz -o /tmp/apache-jmeter-5.5.tgz \
    && tar -xzf /tmp/apache-jmeter-5.5.tgz -C /opt \
    && rm /tmp/apache-jmeter-5.5.tgz

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the default entrypoint
ENTRYPOINT [ "/entrypoint.sh" ]