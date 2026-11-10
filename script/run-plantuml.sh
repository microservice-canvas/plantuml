#! /bin/bash -e

# Renders a PlantUML diagram with the microservicesio/plantuml image: a PNG or an SVG, by the
# output file's extension.
#
#   run-plantuml.sh [--version <image tag>] <diagram.txt> <output.png|output.svg>
#
# A <diagram.txt>.env file is passed to the container, for example to set LEGEND.

VERSION=0.3.0.RELEASE

if [ "$1" == "--version" ] ; then
    shift
    VERSION=$1
    shift
fi

INPUT=${1?}
OUTPUT=${2?}
FORMAT=${OUTPUT##*.}

TMP_OUTPUT=$(mktemp "/tmp/output.$FORMAT.XXXX")

echo "${TMP_OUTPUT}"

ENV_FILE=()
if [ -f "${INPUT}.env" ] ; then
  echo using legend
  cat "${INPUT}.env"
  ENV_FILE=(--env-file "${INPUT}.env")
else
  echo not legend
fi

docker run "${ENV_FILE[@]}" -e "FORMAT=$FORMAT" -i --rm --net=none "microservicesio/plantuml:$VERSION" < "$INPUT" > "${TMP_OUTPUT}"

# An image older than FORMAT ignores it and writes a PNG.
if [ "$FORMAT" == svg ] && ! grep -q '<svg' "${TMP_OUTPUT}" ; then
  rm "${TMP_OUTPUT}"
  echo "microservicesio/plantuml:$VERSION did not render an SVG: it is older than the FORMAT variable" >&2
  exit 1
fi

cat "${TMP_OUTPUT}" > "$OUTPUT"

rm "${TMP_OUTPUT}"
