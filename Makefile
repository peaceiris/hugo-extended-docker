DOCKER_CLI_EXPERIMENTAL := enabled
DOCKER_BUILDKIT := 1

USERNAME := peaceiris
DOCKER_IMAGE_NAME := hugo
DOCKER_HUB_BASE_NAME := ${USERNAME}/${DOCKER_IMAGE_NAME}
DOCKER_BASE_NAME := ghcr.io/${DOCKER_HUB_BASE_NAME}


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

.PHONY: build
build:
	@echo ${DOCKER_BASE_NAME} ${DOCKER_HUB_BASE_NAME}
