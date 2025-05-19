#!/bin/bash
set -e

echo "Running JMeter performance test..."
/jmeter/apache-jmeter-5.6.3/bin/jmeter -n -t /test-plan.jmx -l /results.jtl
