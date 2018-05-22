.PHONY: build push deploy help
.DEFAULT_GOAL:= help

GIT_SHA := $(shell git rev-parse --short HEAD)
GIT_BRANCH := $(shell git rev-parse --symbolic-full-name --abbrev-ref HEAD)
IMAGE_REGISTRY ?= docker.io
IMAGE_NAME ?= cicd-poc1
IMAGE_TAG ?= $(GIT_SHA)
ENV_NAME ?= stg
TARGET_PORT ?= 8080

ifeq ($(ENV_NAME),production)
	TLD = com
else
	TLD = $(ENV_NAME)
endif
ifeq ($(ENV_NAME),$(filter $(ENV_NAME),production stg))
	PLATFORM = gke_
else
	PLATFORM = aws_
endif
export

# CICD test
#ENV_NAME = stg
#PLATFORM = gke_

## Local Testing
run:
	./make-steps/run.sh

## Development
build:
	./make-steps/build.sh

push:
	./make-steps/push.sh

test-unit:
	./make-steps/test-unit.sh

test-container-scan:
	./make-steps/test-container-scan.sh

test-static-code-analysis:
	./make-steps/test-static-code-analysis.sh

alert-qa:
	./make-steps/alert-qa.sh

## Transition
move-to-deploy:
	./make-steps/move-to-deploy.sh

## Staging
deploy-to-stg:
	./make-steps/deploy-to-stg.sh

test-pentest:
	./make-steps/test-pentest.sh

test-load:
	./make-steps/test-load.sh

alert-qa-stg:
	./make-steps/alert-qa-stg.sh

## Transition
move-to-prod:
	./make-steps/move-to-prod.sh

## Release to Prod
#...

firstdeploy:
	./make-steps/firstdeploy.sh

deploy:
	./make-steps/deploy.sh

help:
	@echo ""
	@echo "	GIT_SHA="$$GIT_SHA
	@echo "	GIT_BRANCH="$$GIT_BRANCH
	@echo ""		
	@echo "	The following build/deploy options are available. Default values shown."
	@echo "	..."
	@echo "	IMAGE_REGISTRY="$$IMAGE_REGISTRY
	@echo "	IMAGE_NAME="$$IMAGE_NAME
	@echo "	IMAGE_TAG="$$IMAGE_TAG
	@echo "	ENV_NAME="$$ENV_NAME
	@echo "	..."
	@echo "	Optional ENV_NAME Values: "
	@echo ""
