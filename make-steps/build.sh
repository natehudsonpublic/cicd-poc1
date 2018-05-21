#!/bin/bash

echo "GIT_SHA=${GIT_SHA}"
echo "IMAGE_REGISTRY=${IMAGE_REGISTRY}"
echo "IMAGE_NAME=${IMAGE_NAME}"
echo "IMAGE_TAG=${IMAGE_TAG}"

if [[ -z $DOCKER_USERNAME ]] || [[ -z $DOCKER_PASSWORD ]]; then
	echo "Error: You need to set DOCKER_USERNAME and DOCKER_PASSWORD"
	exit 1;
fi

echo "# login"
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo "# build"
docker build -t $DOCKER_USERNAME/${IMAGE_NAME}:${IMAGE_TAG} --build-arg "GIT_SHA=${GIT_SHA}" .

echo "# check"
docker images | grep -i ${IMAGE_NAME}

echo "# push"
docker push $DOCKER_USERNAME/${IMAGE_NAME}:${IMAGE_TAG}
