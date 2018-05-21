#!/bin/bash

echo "RUNNING: docker run -p ${TARGET_PORT}:${TARGET_PORT} $DOCKER_USERNAME/${IMAGE_NAME}:${IMAGE_TAG}"
docker run -p ${TARGET_PORT}:${TARGET_PORT} $DOCKER_USERNAME/${IMAGE_NAME}:${IMAGE_TAG} 