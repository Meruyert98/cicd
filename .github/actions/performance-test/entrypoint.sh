#!/bin/bash
set -e

# Pull the Docker image
docker pull $1

# Run the Docker container
docker run -d --name app_container $1

# Run JMeter tests
# Assuming you have a JMeter test plan named 'performance-test.jmx' in the repository
jmeter -n -t /path/to/performance-test.jmx -l results.jtl

# Stop and remove the container
docker stop app_container
docker rm app_container

# Output results
cat results.jtl