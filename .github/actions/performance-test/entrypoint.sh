#!/bin/sh

jmeter_test_file=$1

echo "Starting JMeter test: $jmeter_test_file"

jmeter -n -t "$jmeter_test_file" -l result.jtl

echo "JMeter test completed."
