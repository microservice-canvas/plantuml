#! /bin/bash -e

docker build -t plantuml:latest plantuml-container

mkdir -p example-pngs

docker run -i --rm --net=none -e PLANTUML_OPTIONS plantuml:latest < example-diagrams/example-diagram.txt > example-pngs/example-diagram.png

file example-pngs/example-diagram.png
