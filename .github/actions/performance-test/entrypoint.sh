#!/bin/bash

set -e  # Exit on any error

# Variables passed as arguments
CONTAINER_NAME="$1"
URL="$2"

echo "Starting Docker container: $CONTAINER_NAME"
docker run -d --name "$CONTAINER_NAME" -p 8080:8080 flask-app:"${GITHUB_SHA}"

echo "Waiting for application to be available at $URL..."
# Wait until the app responds (up to 30 seconds)
for i in {1..30}; do
    if curl -s --head --fail "$URL" > /dev/null; then
        echo "Application is up!"
        break
    fi
    echo "Waiting... ($i)"
    sleep 1
done

echo "Running JMeter performance tests..."
/opt/apache-jmeter-5.6.3/bin/jmeter -n -t /opt/test-plan.jmx -l /opt/results.jtl -JURL="$URL"

echo "Performance test completed. Stopping container..."
docker stop "$CONTAINER_NAME"
docker rm "$CONTAINER_NAME"

echo "Done."
