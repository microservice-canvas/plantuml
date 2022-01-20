#! /bin/bash -e

TARGET_IMAGE=microservicesio/plantuml:test-build-${CIRCLE_SHA1?}

echo == Test

mkdir -p example-pngs

docker run -i --rm --net=none -e PLANTUML_OPTIONS $TARGET_IMAGE < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png

docker run -i --rm --net=none -e PLANTUML_OPTIONS $TARGET_IMAGE < example-diagrams/example-dot.txt > example-pngs/example-dot.png

file example-pngs/example-dot.png
