FROM openjdk:11-jre-slim

# Set environment variables
ENV JMETER_VERSION=5.6.3
ENV JMETER_HOME=/opt/apache-jmeter-${JMETER_VERSION}

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Install JMeter
RUN curl -L --fail https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz -o /tmp/apache-jmeter.tgz \
    && tar -xzf /tmp/apache-jmeter.tgz -C /opt \
    && rm /tmp/apache-jmeter.tgz

# Copy test plan and entrypoint script
COPY entrypoint.sh /entrypoint.sh
COPY test-plan.jmx /opt/test-plan.jmx

# Set permissions
RUN chmod +x /entrypoint.sh

# Set default entrypoint
ENTRYPOINT [ "/entrypoint.sh" ]
