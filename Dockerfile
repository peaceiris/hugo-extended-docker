ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG DOCKER_HUGO_VERSION="0.80.0"
ENV DOCKER_HUGO_NAME="hugo_extended_${DOCKER_HUGO_VERSION}_Linux-64bit"
ENV DOCKER_HUGO_BASE_URL="https://github.com/gohugoio/hugo/releases/download"
ENV DOCKER_HUGO_URL="${DOCKER_HUGO_BASE_URL}/v${DOCKER_HUGO_VERSION}/${DOCKER_HUGO_NAME}.tar.gz"
ENV DOCKER_HUGO_CHECKSUM_URL="${DOCKER_HUGO_BASE_URL}/v${DOCKER_HUGO_VERSION}/hugo_${DOCKER_HUGO_VERSION}_checksums.txt"
ENV PATH="/assets:${PATH}"
ENV PATH="/assets/sass_embedded:${PATH}"
ENV DEBIAN_FRONTEND="noninteractive"

WORKDIR /assets

RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y --no-install-recommends \
    nodejs \
    git \
    bash \
    make && \
    apt-get autoclean && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    wget --quiet "${DOCKER_HUGO_URL}" && \
    wget --quiet "${DOCKER_HUGO_CHECKSUM_URL}" && \
    grep "${DOCKER_HUGO_NAME}.tar.gz" "./hugo_${DOCKER_HUGO_VERSION}_checksums.txt" | sha256sum -c - && \
    tar -zxvf "${DOCKER_HUGO_NAME}.tar.gz" && \
    rm "${DOCKER_HUGO_NAME}.tar.gz" && \
    hugo version && \
    curl -LJO https://github.com/sass/dart-sass-embedded/releases/download/1.0.0-beta.5/sass_embedded-1.0.0-beta.5-linux-x64.tar.gz && \
    tar -zxvf sass_embedded-1.0.0-beta.5-linux-x64.tar.gz && \
    rm sass_embedded-1.0.0-beta.5-linux-x64.tar.gz && \
    npm i -g npm && \
    npm cache clean --force

WORKDIR /src
ENTRYPOINT [ "/assets/hugo" ]
