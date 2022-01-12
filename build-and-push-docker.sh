#! /bin/bash -e

docker login -u ${DOCKER_USER_ID?} -p ${DOCKER_PASSWORD?}

docker buildx build --platform linux/amd64,linux/arm64 -t microservicesio/plantuml:test-build-${CIRCLE_SHA1:-local} --push plantuml-container
