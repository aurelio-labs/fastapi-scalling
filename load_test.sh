#!/bin/bash

CONCURRENCY=500

TOTAL_REQUESTS=2000

URL="http://localhost:8002/chat"

send_request() {
    curl -s -o /dev/null -w "%{http_code}" "$URL"
}

# Export the function for parallel execution
export -f send_request
export URL

seq $TOTAL_REQUESTS | xargs -n1 -P$CONCURRENCY bash -c 'send_request'