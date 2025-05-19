#!/bin/sh
# .github/actions/performance-test/entrypoint.sh

set -e

TEST_PLAN=${1:-test-plan.jmx}

echo "Running JMeter performance test with plan: $TEST_PLAN"

if [ ! -f "$TEST_PLAN" ]; then
  echo "ERROR: Test plan file $TEST_PLAN does not exist."
  exit 1
fi

jmeter -n -t "$TEST_PLAN" -l results.jtl

# You could add more steps here, like uploading results as artifacts
echo "Performance test completed."

exit 0
