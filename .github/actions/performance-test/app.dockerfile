FROM apache-jmeter:latest

# Copy the JMeter test plan into the container
COPY performance-test.jmx /path/to/performance-test.jmx

ENTRYPOINT ["/entrypoint.sh"]