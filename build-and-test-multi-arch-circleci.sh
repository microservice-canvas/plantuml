#! /bin/bash -e

TAG=microservicesio/plantuml:test-build-${CIRCLE_SHA1:-local}

docker login -u ${DOCKER_USER_ID?} -p ${DOCKER_PASSWORD?}

docker buildx build --platform linux/amd64,linux/arm64 -t $TAG --push .

echo == Architecture

echo TAG=$TAG

docker images

env

docker pull $TAG
docker inspect $TAG --format '{{.Architecture}}'

echo == The manifest

docker manifest inspect --insecure $TAG

echo == Test

mkdir -p example-pngs

docker run -i --rm --net=none -e PLANTUML_OPTIONS $TAG < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png
