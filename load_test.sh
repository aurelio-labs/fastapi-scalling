#!/bin/bash

URL="http://keda.fastapi.localdev.me/docs"

RPS=100
DURATION=30

send_request() {
    curl -s -o /dev/null -w "%{http_code}" "$URL" &
}

start_time=$(date +%s)
end_time=$((start_time + DURATION))

while [ $(date +%s) -lt $end_time ]; do
    batch_start=$(date +%s.%N)
    for ((j=1; j<=RPS; j++)); do
        send_request
    done
    batch_end=$(date +%s.%N)
    elapsed=$(echo "$batch_end - $batch_start" | bc)
    sleep_time=$(echo "1 - $elapsed" | bc)
    if (( $(echo "$sleep_time > 0" | bc -l) )); then
        sleep $sleep_time
    fi
done

wait

total_requests=$((RPS * DURATION))
echo "Load test completed: $total_requests requests sent at $RPS RPS for $DURATION seconds"
