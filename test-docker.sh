#! /bin/bash -e

mkdir -p example-pngs

docker run -i --rm --net=none -e PLANTUML_OPTIONS microservicesio/plantuml:test-build-${CIRCLE_SHA1:-local} < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png
