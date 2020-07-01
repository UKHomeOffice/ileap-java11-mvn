### BUILD image
FROM quay.io/ukhomeofficedigital/java11-mvn:11.0.5_10-mvn-3.6.3 as builder
ARG ART_USERNAME
ARG ART_PASSWORD

ENV ARTIFACTORY_USERNAME=${ART_USERNAME} \
    ARTIFACTORY_PASSWORD=${ART_PASSWORD}

RUN mkdir -p /scripts

RUN groupadd -r gap -g 1000 && useradd -u 1000 -r -g gap -m -d /build -s /sbin/nologin -c "GAP user" gap && \
    chmod 755 /build

WORKDIR /scripts
COPY ./scripts /scripts
