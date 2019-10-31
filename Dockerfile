FROM alpine:3.10

ENV HUGO_VERSION='0.59.1'
ENV HUGO_NAME="hugo_extended_${HUGO_VERSION}_Linux-64bit"
ENV HUGO_BASE_URL="https://github.com/gohugoio/hugo/releases/download"
ENV HUGO_URL="${HUGO_BASE_URL}/v${HUGO_VERSION}/${HUGO_NAME}.tar.gz"
ENV HUGO_CHECKSUM_URL="${HUGO_BASE_URL}/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_checksums.txt"

WORKDIR /hugo
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache --virtual .build-deps wget && \
    apk add --no-cache \
    git \
    ca-certificates \
    libc6-compat \
    libstdc++ && \
    wget --quiet "${HUGO_URL}" && \
    wget --quiet "${HUGO_CHECKSUM_URL}" && \
    grep "${HUGO_NAME}.tar.gz" "./hugo_${HUGO_VERSION}_checksums.txt" | sha256sum -c - && \
    tar -zxvf "${HUGO_NAME}.tar.gz" && \
    mv ./hugo /usr/bin/hugo && \
    apk del .build-deps && \
    rm -rf /hugo

WORKDIR /src
ENTRYPOINT [ "/usr/bin/hugo" ]
