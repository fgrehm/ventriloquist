# Base openjdk image

FROM fgrehm/ventriloquist-base

RUN apt-get update && \
    apt-get install -y openjdk-7-jre-headless && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean
