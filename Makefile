DOCKER_CLI_EXPERIMENTAL := enabled
DOCKER_BUILDKIT := 1

USERNAME := peaceiris
DOCKER_IMAGE_NAME := hugo
DOCKER_HUB_BASE_NAME := ${USERNAME}/${DOCKER_IMAGE_NAME}
DOCKER_BASE_NAME := ghcr.io/${DOCKER_HUB_BASE_NAME}

TAG_NAME := latest
PKG_TAG := ${DOCKER_BASE_NAME}:${TAG_NAME}
HUB_TAG := ${DOCKER_HUB_BASE_NAME}:${TAG_NAME}

DOCKER_HUGO_VERSION := $(shell cd ./deps && go mod edit -json | jq -r '.Require[] | select(.Path == "github.com/gohugoio/hugo") | .Version | split("v") | .[1]')
DOCKER_SCOPE := docker-${TAG_NAME}

.PHONY: get-go-version
get-go-version:
	@cd ./deps && go mod edit -json | jq -r '.Go'

.PHONY: get-hugo-version
get-hugo-version:
	@cd ./deps && go mod edit -json | jq -r '.Require[] | select(.Path == "github.com/gohugoio/hugo") | .Version | split("v") | .[1]'


.PHONY: login
login:
	echo "${DOCKER_HUB_TOKEN}" | docker login -u peaceiris --password-stdin

.PHONY: login-ghcr
login-ghcr:
	echo "${GITHUB_TOKEN}" | docker login ghcr.io -u ayamebot --password-stdin


.PHONY: setup-buildx
setup-buildx:
	docker buildx create --use --driver docker-container


.PHONY: build-slim
build-slim:
	docker buildx build . \
		--tag "${PKG_TAG}" \
		--platform "linux/amd64" \
		--build-arg DOCKER_HUGO_VERSION="${DOCKER_HUGO_VERSION}" \
		--build-arg BASE_IMAGE="alpine:3.15" \
		--build-arg INSTALL_NODE="false" \
		--cache-from "type=gha,scope=${DOCKER_SCOPE}" \
		--cache-to "type=gha,mode=max,scope=${DOCKER_SCOPE}" \
		--output "type=docker"

.PHONY: build-mod
build-mod:
	@echo ${DOCKER_BASE_NAME} ${DOCKER_HUB_BASE_NAME}

.PHONY: build-full
build-full:
	@echo ${DOCKER_BASE_NAME} ${DOCKER_HUB_BASE_NAME}
