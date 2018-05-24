#!/bin/bash

echo "# START build"

if [[ ! -z $TRAVIS_BRANCH ]]; then
	echo "# overriding GIT_BRANCH with TRAVIS_BRANCH"
	GIT_BRANCH=$TRAVIS_BRANCH
fi

if [[ ! -z $CI_COMMIT_REF_NAME ]]; then
	echo "# overriding GIT_BRANCH with gitlab CI_COMMIT_REF_NAME"
	GIT_BRANCH=$CI_COMMIT_REF_NAME

if [[ $GIT_BRANCH == "develop" ]]; then
	IMAGE_TAG="dev-${IMAGE_TAG}"
fi

if [[ $GIT_BRANCH == "stg" ]]; then
	IMAGE_TAG="stg-${IMAGE_TAG}"
fi

echo "GIT_SHA=${GIT_SHA}"
echo "GIT_BRANCH=${GIT_BRANCH}"
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
docker build -t $DOCKER_USERNAME/${IMAGE_NAME}:${IMAGE_TAG} --build-arg "GIT_SHA=${GIT_SHA}" --build-arg "GIT_BRANCH=${GIT_BRANCH}" .

echo "# check"
docker images | grep -i ${IMAGE_NAME}

echo "# push"
docker push $DOCKER_USERNAME/${IMAGE_NAME}:${IMAGE_TAG}


