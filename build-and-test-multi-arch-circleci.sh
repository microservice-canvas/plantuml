#! /bin/bash -e

TARGET_IMAGE=microservicesio/plantuml:test-build-${CIRCLE_SHA1?}

docker login -u ${DOCKER_USER_ID?} -p ${DOCKER_PASSWORD?}

docker buildx build --platform linux/amd64,linux/arm64 -t $TARGET_IMAGE --push plantuml-container

echo == Architecture

echo TARGET_IMAGE=$TARGET_IMAGE

docker images

env

docker pull $TARGET_IMAGE
docker inspect $TARGET_IMAGE --format '{{.Architecture}}'

echo == The manifest

docker manifest inspect --insecure $TARGET_IMAGE

echo == Test

mkdir -p example-pngs

docker run -i --rm --net=none -e PLANTUML_OPTIONS $TARGET_IMAGE < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png

docker run -i --rm --net=none -e PLANTUML_OPTIONS $TARGET_IMAGE < example-diagrams/example-dot.txt > example-pngs/example-dot.png

file example-pngs/example-dot.png
