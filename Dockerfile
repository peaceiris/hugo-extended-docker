FROM debian:9-slim

ENV HUGO_VERSION='0.55.6'
ENV HUGO_NAME="hugo_extended_${HUGO_VERSION}_Linux-64bit"
ENV HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_NAME}.deb"
ENV BUILD_DEPS="wget"

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git "${BUILD_DEPS}" && \
    wget "${HUGO_URL}" && \
    apt-get install "./${HUGO_NAME}.deb" && \
    rm -rf "./${HUGO_NAME}.deb" "${HUGO_NAME}" && \
    apt-get remove -y "${BUILD_DEPS}" && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
