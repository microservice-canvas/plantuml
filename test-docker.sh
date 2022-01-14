#! /bin/bash -e

mkdir -p example-pngs

VERSION=test-build-${CIRCLE_SHA1:-local}

if [ "$1" == "--version" ] ; then
    shift
    VERSION=$1
    shift
fi

docker run -i --rm --net=none -e PLANTUML_OPTIONS microservicesio/plantuml:${VERSION} < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png
