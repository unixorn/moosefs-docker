.PHONY: c clean \
	f format \
	h help \
	local \
	multiarch_image \
	publish \
	t test \
	wheel

h: help
c: clean
f: format
t: test

help:
	@echo "Options:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

HUB_USER=unixorn
MOOSEFS_VERSION=3.116
PLATFORMS=linux/arm64,linux/amd64,linux/arm/v7

# If this pukes trying to import paho, try running 'poetry install'
# MOOSEFS_VERSION=$(shell poetry run python3 -c 'from ha_mqtt_discoverable import __version__;print(__version__)' )

install_hooks: ## Install the git hooks
	poetry run pre-commit install

local_cgiserver: ## Makes a moosefs-cgiserver docker image for only the architecture we're running on. Does not push to dockerhub.
	docker buildx build --pull --load -t ${HUB_USER}/moosefs-cgiserver -f Dockerfile.cgiserver .

multiarch_cgiserver: ## Makes a moosefs-cgiserver multi-architecture docker image for linux/arm64, linux/amd64 and linux/arm/v7 and pushes it to dockerhub
	docker buildx build --build-arg application_version=${MOOSEFS_VERSION} --platform ${PLATFORMS} --pull --push -t ${HUB_USER}/moosefs-cgiserver:$(MOOSEFS_VERSION) -f Dockerfile.cgiserver .
	docker buildx build --build-arg application_version=${MOOSEFS_VERSION} --platform ${PLATFORMS} --pull --push -t ${HUB_USER}/moosefs-cgiserver:latest -f Dockerfile.cgiserver .
	docker pull ${HUB_USER}/moosefs-cgiserver:latest


local_chunkserver: ## Makes a moosefs-chunkserver docker image for only the architecture we're running on. Does not push to dockerhub.
	docker buildx build --pull --load -t ${HUB_USER}/moosefs-chunkserver -f Dockerfile.chunkserver .

multiarch_chunkserver: ## Makes a moosefs-chunkserver multi-architecture docker image for linux/arm64, linux/amd64 and linux/arm/v7 and pushes it to dockerhub
	docker buildx build --build-arg application_version=${MOOSEFS_VERSION} --platform ${PLATFORMS} --pull --push -t ${HUB_USER}/moosefs-chunkserver:$(MOOSEFS_VERSION) -f Dockerfile.chunkserver .
	docker buildx build --build-arg application_version=${MOOSEFS_VERSION} --platform ${PLATFORMS} --pull --push -t ${HUB_USER}/moosefs-chunkserver:latest -f Dockerfile.chunkserver .
	docker pull ${HUB_USER}/moosefs-chunkserver:latest


local_master: ## Makes a moosefs-master docker image for only the architecture we're running on. Does not push to dockerhub.
	docker buildx build --pull --load -t ${HUB_USER}/moosefs-master -f Dockerfile.master .

multiarch_master: ## Makes a moosefs-master multi-architecture docker image for linux/arm64, linux/amd64 and linux/arm/v7 and pushes it to dockerhub
	docker buildx build --build-arg application_version=${MOOSEFS_VERSION} --platform ${PLATFORMS} --pull --push -t ${HUB_USER}/moosefs-master:$(MOOSEFS_VERSION) -f Dockerfile.master .
	docker buildx build --build-arg application_version=${MOOSEFS_VERSION} --platform ${PLATFORMS} --pull --push -t ${HUB_USER}/moosefs-master:latest -f Dockerfile.master .
	docker pull ${HUB_USER}/moosefs-master:latest

local_metalogger: ## Makes a moosefs-metalogger docker image for only the architecture we're running on. Does not push to dockerhub.
	docker buildx build --pull --load -t ${HUB_USER}/moosefs-metalogger -f Dockerfile.metalogger .

multiarch_metalogger: ## Makes a moosefs-metalogger multi-architecture docker image for linux/arm64, linux/amd64 and linux/arm/v7 and pushes it to dockerhub
	docker buildx build --build-arg application_version=${MOOSEFS_VERSION} --platform ${PLATFORMS} --pull --push -t ${HUB_USER}/moosefs-metalogger:$(MOOSEFS_VERSION) -f Dockerfile.metalogger .
	docker buildx build --build-arg application_version=${MOOSEFS_VERSION} --platform ${PLATFORMS} --pull --push -t ${HUB_USER}/moosefs-metalogger:latest -f Dockerfile.metalogger .
	docker pull ${HUB_USER}/moosefs-metalogger:latest

local: local_cgiserver \ ## Make images for whatever architecture you're running on, but does not push to docker hub
	local_chunkserver \
	local_master \
	local_metalogger

multiarch_images: multiarch ## Builds multi-architecture docker images for all the services and pushes them to docker hub
multiarch: multiarch_cgiserver \
	multiarch_chunkserver \
	multiarch_master \
	multiarch_metalogger