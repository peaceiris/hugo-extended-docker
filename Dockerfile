ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG DOCKER_HUGO_VERSION="0.89.1"
ENV DOCKER_HUGO_NAME="hugo_extended_${DOCKER_HUGO_VERSION}_Linux-64bit"
ENV DOCKER_HUGO_BASE_URL="https://github.com/gohugoio/hugo/releases/download"
ENV DOCKER_HUGO_URL="${DOCKER_HUGO_BASE_URL}/v${DOCKER_HUGO_VERSION}/${DOCKER_HUGO_NAME}.tar.gz"
ENV DOCKER_HUGO_CHECKSUM_URL="${DOCKER_HUGO_BASE_URL}/v${DOCKER_HUGO_VERSION}/hugo_${DOCKER_HUGO_VERSION}_checksums.txt"
ARG INSTALL_NODE="false"

WORKDIR /build
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --update-cache --no-cache --virtual .build-deps wget && \
    apk add --update-cache --no-cache \
    git \
    bash \
    make \
    ca-certificates \
    libc6-compat \
    libstdc++ && \
    wget --quiet "${DOCKER_HUGO_URL}" && \
    wget --quiet "${DOCKER_HUGO_CHECKSUM_URL}" && \
    grep "${DOCKER_HUGO_NAME}.tar.gz" "./hugo_${DOCKER_HUGO_VERSION}_checksums.txt" | sha256sum -c - && \
    tar -zxvf "${DOCKER_HUGO_NAME}.tar.gz" && \
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
