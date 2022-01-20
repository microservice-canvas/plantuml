#! /bin/bash -e

TARGET_IMAGE=microservicesio/plantuml:test-build-${CIRCLE_SHA1?}

docker login -u ${DOCKER_USER_ID?} -p ${DOCKER_PASSWORD?}

docker buildx build --platform linux/amd64,linux/arm64 -t $TARGET_IMAGE --push plantuml-container

echo == Architecture

echo TARGET_IMAGE=$TARGET_IMAGE

docker images

docker pull $TARGET_IMAGE
docker inspect $TARGET_IMAGE --format '{{.Architecture}}'

echo == The manifest

docker manifest inspect --insecure $TARGET_IMAGE
