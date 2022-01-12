#! /bin/bash -e

docker run -i --rm --net=none -e PLANTUML_OPTIONS microservicesio/plantuml:test-build-${CIRCLE_BUILD_NUM:-local} < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png
