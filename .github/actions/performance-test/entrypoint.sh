#!/bin/bash

set -e  # Exit script on error

# Variables passed from inputs
CONTAINER_NAME="$1"
URL="$2"

echo "Starting Docker container for performance testing..."
docker run -d --name "$CONTAINER_NAME" -p 8080:8080 flask-app:"${GITHUB_SHA}"

echo "Running JMeter tests..."
# Ensure JMeter binary directory exists
if [ ! -d "/opt/apache-jmeter-5.5" ]; then
  echo "Error: JMeter is not installed in the container. Exiting!"
  exit 1
fi

# Run JMeter performance tests
/opt/apache-jmeter-5.5/bin/jmeter -n -t /opt/test-plan.jmx -l results.jtl -JURL="$URL"

echo "Stopping and cleaning up Docker container..."
docker stop "$CONTAINER_NAME"
docker rm "$CONTAINER_NAME"

echo "Performance test completed successfully."