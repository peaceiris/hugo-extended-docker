FROM alpine:3.9

ENV GLIBC_VERSION="2.28-r0"
RUN apk add --no-cache \
    git \
    libstdc++ \
    ca-certificates \
    wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk" && \
    apk --no-cache add "glibc-$GLIBC_VERSION.apk" && \
    rm "glibc-$GLIBC_VERSION.apk" && \
    wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-bin-$GLIBC_VERSION.apk" && \
    apk --no-cache add "glibc-bin-$GLIBC_VERSION.apk" && \
    rm "glibc-bin-$GLIBC_VERSION.apk" && \
    wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-i18n-$GLIBC_VERSION.apk" && \
    apk --no-cache add "glibc-i18n-$GLIBC_VERSION.apk" && \
    rm "glibc-i18n-$GLIBC_VERSION.apk" && \
    apk del ca-certificates wget

ENV HUGO_VERSION=0.55.6
ENV HUGO_TYPE=_extended

ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}_Linux-64bit.tar.gz /tmp
RUN tar -xf /tmp/${HUGO_ID}_Linux-64bit.tar.gz -C /tmp \
    && mkdir -p /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
    && rm -rf /tmp/${HUGO_ID}_Linux-64bit.tar.gz \
    && rm -rf /tmp/LICENSE.md \
    && rm -rf /tmp/README.md

WORKDIR /src
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
