#! /bin/bash -e

docker-compose up -d

PORT=$(docker-compose port registry 5000 | sed 's/.*://')
BUILD_TARGET_IMAGE=host.docker.internal:$PORT/plantuml:test-build
RUN_TARGET_IMAGE=localhost:$PORT/plantuml:test-build

echo BUILD_TARGET_IMAGE=$BUILD_TARGET_IMAGE RUN_TARGET_IMAGE=$RUN_TARGET_IMAGE

docker buildx build --platform linux/amd64,linux/arm64 -t $BUILD_TARGET_IMAGE \
  --output=type=image,push=true,registry.insecure=true plantuml-container

echo == Architecture

docker inspect $RUN_TARGET_IMAGE --format '{{.Architecture}}'

echo == The manifest

docker manifest inspect --insecure $RUN_TARGET_IMAGE

echo == Test

mkdir -p example-pngs

docker run -i --rm --net=none -e PLANTUML_OPTIONS $RUN_TARGET_IMAGE < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png

docker run -i --rm --net=none -e PLANTUML_OPTIONS $RUN_TARGET_IMAGE < example-diagrams/example-dot.txt > example-pngs/example-dot.png

file example-pngs/example-dot.png

# docker-compose down
