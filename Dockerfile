ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG HUGO_VERSION="0.76.3"
ENV HUGO_NAME="hugo_extended_${HUGO_VERSION}_Linux-64bit"
ENV HUGO_BASE_URL="https://github.com/gohugoio/hugo/releases/download"
ENV HUGO_URL="${HUGO_BASE_URL}/v${HUGO_VERSION}/${HUGO_NAME}.tar.gz"
ENV HUGO_CHECKSUM_URL="${HUGO_BASE_URL}/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_checksums.txt"
ARG INSTALL_NODE="false"

WORKDIR /build
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache --virtual .build-deps wget && \
    apk add --no-cache \
    git \
    bash \
    make \
    ca-certificates \
    libc6-compat \
    libstdc++ && \
    wget --quiet "${HUGO_URL}" && \
    wget --quiet "${HUGO_CHECKSUM_URL}" && \
    grep "${HUGO_NAME}.tar.gz" "./hugo_${HUGO_VERSION}_checksums.txt" | sha256sum -c - && \
    tar -zxvf "${HUGO_NAME}.tar.gz" && \
    mv ./hugo /usr/bin/hugo && \
    hugo version && \
    apk del .build-deps && \
    if [ "${INSTALL_NODE}" = "true" ]; then \
        echo "Installing Node.js and npm..." && \
        apk add --no-cache nodejs npm && \
        npm i -g npm && \
        npm cache clean --force && \
        echo "node version: $(node -v)" && \
        echo "npm version: $(npm -v)"; \
    fi && \
    rm -rf /build

WORKDIR /src
ENTRYPOINT [ "/usr/bin/hugo" ]
