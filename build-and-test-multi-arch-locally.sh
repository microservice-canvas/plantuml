#! /bin/bash -e

docker-compose up -d

XX=plantuml
XX=test-tiny

PORT=$(docker-compose port registry 5000 | sed 's/.*://')
BUILD_TAG=host.docker.internal:$PORT/plantuml:$XX
TAG=${LOCAL_DOCKER_HOST-localhost:$PORT/}plantuml:$XX

echo BUILD_TAG=$BUILD_TAG TAG=$TAG

docker buildx build --platform linux/amd64,linux/arm64 -t $BUILD_TAG \
  --output=type=image,push=true,registry.insecure=true -f plantuml-container/Dockerfile.tiny .

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

# docker-compose down
