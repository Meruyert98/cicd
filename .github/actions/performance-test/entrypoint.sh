#!/bin/bash

set -e

# Variables from inputs
CONTAINER_NAME=$1
URL=$2

echo "Starting Docker container for performance testing..."
docker run -d --name "$CONTAINER_NAME" -p 8080:8080 my-python-app:"${GITHUB_SHA}"

echo "Running JMeter tests..."
# Download JMeter if not already downloaded
if [ ! -d "apache-jmeter-5.5" ]; then
  echo "Downloading JMeter..."
  curl -L https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.5.tgz | tar xz
fi

./apache-jmeter-5.5/bin/jmeter -n -t ./test-plan.jmx -l results.jtl -JURL="$URL"

echo "Stopping and cleaning up Docker container..."
docker stop "$CONTAINER_NAME"
docker rm "$CONTAINER_NAME"

echo "Performance test completed successfully."