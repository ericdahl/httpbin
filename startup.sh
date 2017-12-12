#!/bin/sh

if [ -n "${DELAY_START_CONNECT}" ]; then
    echo "Sleeping for [${DELAY_START_CONNECT}] seconds"
    sleep "${DELAY_START_CONNECT}"
fi

gunicorn -b 0.0.0.0:8080 --access-logfile - httpbin:app
