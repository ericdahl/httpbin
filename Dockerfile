FROM python:3-alpine

ENV WEB_CONCURRENCY=4

ADD . /httpbin

RUN apk add -U ca-certificates libffi libstdc++ && \
    apk add --virtual build-deps build-base libffi-dev && \
    # Pip
    pip install --no-cache-dir gunicorn /httpbin && \
    # Cleaning up
    apk del build-deps && \
    rm -rf /var/cache/apk/*

EXPOSE 8080

# Add 1 GB of garbage to the image for testing some special cases
# with ECS
#RUN dd if=/dev/urandom of=/garbage.bin bs=1024 count=1024000

# CMD ["gunicorn", "-b", "0.0.0.0:8080", "httpbin:app"]
CMD ["httpbin/startup.sh"]
