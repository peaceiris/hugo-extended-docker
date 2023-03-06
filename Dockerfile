ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG DOCKER_HUGO_VERSION
ENV DOCKER_HUGO_NAME="hugo_extended_${DOCKER_HUGO_VERSION}_Linux-64bit"
ENV DOCKER_HUGO_BASE_URL="https://github.com/gohugoio/hugo/releases/download"
ENV DOCKER_HUGO_URL="${DOCKER_HUGO_BASE_URL}/v${DOCKER_HUGO_VERSION}/${DOCKER_HUGO_NAME}.tar.gz"
ENV DOCKER_HUGO_CHECKSUM_URL="${DOCKER_HUGO_BASE_URL}/v${DOCKER_HUGO_VERSION}/hugo_${DOCKER_HUGO_VERSION}_checksums.txt"
ARG INSTALL_NODE="false"

WORKDIR /build
SHELL ["/bin/bash", "-eo", "pipefail", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git make jq && \
    curl -OL --silent "${DOCKER_HUGO_URL}" && \
    curl -OL --silent "${DOCKER_HUGO_CHECKSUM_URL}" && \
    grep "${DOCKER_HUGO_NAME}.tar.gz" "./hugo_${DOCKER_HUGO_VERSION}_checksums.txt" | sha256sum -c - && \
    tar -zxvf "${DOCKER_HUGO_NAME}.tar.gz" && \
    mv ./hugo /usr/bin/hugo && \
    hugo version && \
    apt-get autoclean && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    if [ "${INSTALL_NODE}" = "true" ]; then \
        echo "Installing Node.js and npm..." && \
        curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
        apt-get install -y --no-install-recommends nodejs && \
        npm i -g npm && \
        npm cache clean --force && \
        echo "node version: $(node -v)" && \
        echo "npm version: $(npm -v)"; \
    fi && \
    rm -rf /build

WORKDIR /src
ENTRYPOINT [ "/usr/bin/hugo" ]
