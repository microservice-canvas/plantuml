#! /bin/bash -e

docker-compose up -d

BUILD_TAG=host.docker.internal:5000/plantuml:test-build
TAG=localhost:5000/plantuml:test-build

docker buildx build --platform linux/amd64,linux/arm64 -t $BUILD_TAG \
  --output=type=image,push=true,registry.insecure=true plantuml-container

docker run -i --rm --net=none -e PLANTUML_OPTIONS $TAG < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png

# docker-compose down
