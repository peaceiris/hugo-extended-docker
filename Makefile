DOCKER_CLI_EXPERIMENTAL := enabled
DOCKER_BUILDKIT := 1

USERNAME := peaceiris
DOCKER_IMAGE_NAME := hugo
DOCKER_HUB_BASE_NAME := ${USERNAME}/${DOCKER_IMAGE_NAME}
DOCKER_BASE_NAME := ghcr.io/${DOCKER_HUB_BASE_NAME}
DOCKER_HUGO_VERSION := $(shell cd ./deps && go mod edit -json | jq -r '.Require[] | select(.Path == "github.com/gohugoio/hugo") | .Version | split("v") | .[1]')

TAG_SPEC := v${DOCKER_HUGO_VERSION}
DOCKER_SCOPE := docker-${TAG_SPEC}

PKG_SPEC := ${DOCKER_BASE_NAME}:${TAG_SPEC}
HUB_SPEC := ${DOCKER_HUB_BASE_NAME}:${TAG_SPEC}
TAG_LATEST := latest
PKG_LATEST := ${DOCKER_BASE_NAME}:${TAG_LATEST}
HUB_LATEST := ${DOCKER_HUB_BASE_NAME}:${TAG_LATEST}


.PHONY: get-go-version
get-go-version:
	@cd ./deps && go mod edit -json | jq -r '.Go'


.PHONY: login
login:
	echo "${DOCKER_HUB_TOKEN}" | docker login -u peaceiris --password-stdin

.PHONY: login-ghcr
login-ghcr:
	echo "${GITHUB_TOKEN}" | docker login ghcr.io -u ayamebot --password-stdin

.PHONY: setup-buildx
setup-buildx:
	docker buildx create --use --driver docker-container
	docker version

.PHONY: build-tpl
build-tpl:
	docker buildx build . \
		--tag "${PKG_NAME}" \
		--platform "linux/amd64" \
		--build-arg DOCKER_HUGO_VERSION="${DOCKER_HUGO_VERSION}" \
		--build-arg BASE_IMAGE="${BASE_IMAGE}" \
		--build-arg INSTALL_NODE="${INSTALL_NODE}" \
		--output "type=docker" \
		--cache-from "type=gha,scope=${DOCKER_SCOPE}" \
		--cache-to "type=gha,mode=max,scope=${DOCKER_SCOPE}"

.PHONY: tag
tag:
	docker tag ${PKG_SPEC} ${HUB_SPEC}
	docker tag ${PKG_SPEC} ${HUB_LATEST}
	docker tag ${PKG_SPEC} ${PKG_LATEST}

.PHONY: dump
dump:
	docker run --rm "${PKG_NAME}" version

.PHONY: build
build: setup-buildx build-slim build-mod build-full
	docker images

.PHONY: build-slim
build-slim:
	$(MAKE) build-tpl \
		PKG_NAME="${PKG_SPEC}" \
		BASE_IMAGE="alpine:3.15" \
		INSTALL_NODE="false"
	$(MAKE) tag \
		TAG_SPEC="v${DOCKER_HUGO_VERSION}" \
		TAG_LATEST="latest"
	$(MAKE) dump PKG_NAME="${PKG_SPEC}"

.PHONY: build-mod
build-mod:
	$(MAKE) build-tpl \
		PKG_NAME="${PKG_SPEC}-mod" \
		BASE_IMAGE="golang:1.18-alpine3.15" \
		INSTALL_NODE="false"
	$(MAKE) tag \
		TAG_SPEC="v${DOCKER_HUGO_VERSION}-mod" \
		TAG_LATEST="latest-mod"
	$(MAKE) dump PKG_NAME="${PKG_SPEC}-mod"

.PHONY: build-full
build-full:
	$(MAKE) build-tpl \
		PKG_NAME="${PKG_SPEC}-full" \
		BASE_IMAGE="golang:1.18-alpine3.15" \
		INSTALL_NODE="true"
	$(MAKE) tag \
		TAG_SPEC="v${DOCKER_HUGO_VERSION}-full" \
		TAG_LATEST="latest-full"
	$(MAKE) dump PKG_NAME="${PKG_SPEC}-full"

.PHONY: push-tpl
push-tpl:
	echo "${PKG_SPEC}\n${HUB_SPEC}" | xargs -I % docker push %
	echo "${PKG_LATEST}\n${HUB_LATEST}" | xargs -I % docker push %

.PHONY: push-slim
push-slim:
	$(MAKE) push-tpl \
		TAG_SPEC="v${DOCKER_HUGO_VERSION}" \
		TAG_LATEST="latest"

.PHONY: push-mod
push-mod:
	$(MAKE) push-tpl \
		TAG_SPEC="v${DOCKER_HUGO_VERSION}-mod" \
		TAG_LATEST="latest-mod"

.PHONY: push-full
push-full:
	$(MAKE) push-tpl \
		TAG_SPEC="v${DOCKER_HUGO_VERSION}-full" \
		TAG_LATEST="latest-full"
