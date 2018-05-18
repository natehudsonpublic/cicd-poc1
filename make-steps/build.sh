#!/bin/bash

echo "GIT_SHA=${GIT_SHA}"
echo "IMAGE_REGISTRY=${IMAGE_REGISTRY}"
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "IMAGE_TAG=${IMAGE_TAG}"

#echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
#docker build -t travis-ci-build-stages-demo .
#docker images
#docker tag travis-ci-build-stages-demo $DOCKER_USERNAME/travis-ci-build-stages-demo
#docker push $DOCKER_USERNAME/travis-ci-build-stages-demo
