.DEFAULT_GOAL := help

FLINK_VERSION_FULL=1.20.1
PLATFORM=arm64v8
#PLATFORM=flink

define HELP

Available commands:

- pullall: Pull all source images.

- build:   Build all images.

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help


pull_all: flink polaris datastores
	@echo "✅ All source images pulled successfully"
.PHONY: pull


flink:
	docker pull arm64v8/flink:${FLINK_VERSION_FULL}-scala_2.12-java17

polaris:
	docker pull apache/polaris:latest
	docker pull alpine/curl:latest
	docker pull apache/polaris-admin-tool:latest


datastores:
	docker pull postgres:12
	docker pull quay.io/minio/minio:RELEASE.2024-12-18T13-15-44Z
	docker pull minio/mc:latest

# Using above image as it still includes the full console functionality 
# or if you want to use the latest current image available.
#	docker pull minio/minio:latest

build:
	@echo "🔨 Building all Docker images..."
	@cd flink && make pull && make build
	@echo "✅ All images built successfully"
.PHONY: build