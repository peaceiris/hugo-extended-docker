DOCKER_CLI_EXPERIMENTAL := enabled
DOCKER_BUILDKIT := 1

USERNAME := peaceiris
DOCKER_IMAGE_NAME := hugo
DOCKER_HUB_BASE_NAME := ${USERNAME}/${DOCKER_IMAGE_NAME}
DOCKER_BASE_NAME := ghcr.io/${DOCKER_HUB_BASE_NAME}
DOCKER_SCOPE := docker-${TAG_NAME}
DOCKER_HUGO_VERSION := $(shell cd ./deps && go mod edit -json | jq -r '.Require[] | select(.Path == "github.com/gohugoio/hugo") | .Version | split("v") | .[1]')

TAG_NAME := v${DOCKER_HUGO_VERSION}
PKG_TAG := ${DOCKER_BASE_NAME}:${TAG_NAME}
HUB_TAG := ${DOCKER_HUB_BASE_NAME}:${TAG_NAME}
TAG_NAME_LATEST := "latest"
PKG_TAG_LATEST := ${DOCKER_BASE_NAME}:${TAG_NAME_LATEST}
HUB_TAG_LATEST := ${DOCKER_HUB_BASE_NAME}:${TAG_NAME_LATEST}


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
	docker tag ${PKG_NAME} ${HUB_TAG}
	docker tag ${PKG_NAME} ${PKG_TAG_LATEST}
	docker tag ${PKG_NAME} ${HUB_TAG_LATEST}

.PHONY: dump
dump:
	docker run --rm "${PKG_NAME}" version

.PHONY: build
build: setup-buildx build-slim build-mod build-full
	docker images

.PHONY: build-slim
build-slim:
	$(MAKE) build-tpl \
		PKG_NAME="${PKG_TAG}" \
		BASE_IMAGE="alpine:3.15" \
		INSTALL_NODE="false"
	$(MAKE) tag \
		PKG_NAME="${PKG_TAG}" \
		TAG_NAME_LATEST="${TAG_NAME_LATEST}" \
		HUB_TAG="${HUB_TAG}"
	$(MAKE) dump PKG_NAME="${PKG_TAG}"

.PHONY: build-mod
build-mod:
	$(MAKE) build-tpl \
		PKG_NAME="${PKG_TAG}-mod" \
		BASE_IMAGE="golang:1.18-alpine3.15" \
		INSTALL_NODE="false"
	$(MAKE) tag \
		PKG_NAME="${PKG_TAG}-mod" \
		TAG_NAME_LATEST="${TAG_NAME_LATEST}-mod" \
		HUB_TAG="${HUB_TAG}-mod"
	$(MAKE) dump PKG_NAME="${PKG_TAG}"

.PHONY: build-full
build-full:
	$(MAKE) build-tpl \
		PKG_NAME="${PKG_TAG}-full" \
		BASE_IMAGE="golang:1.18-alpine3.15" \
		INSTALL_NODE="true"
	$(MAKE) tag \
		PKG_NAME="${PKG_TAG}-full" \
		TAG_NAME_LATEST="${TAG_NAME_LATEST}-full" \
		HUB_TAG="${HUB_TAG}-full"
	$(MAKE) dump PKG_NAME="${PKG_TAG}"
