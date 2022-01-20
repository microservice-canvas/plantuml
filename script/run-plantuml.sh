#! /bin/bash -e

TMP_PNG=$(mktemp /tmp/output.png.XXXX)

echo "${TMP_PNG}"

VERSION=0.3.0.RELEASE

if [ "$1" == "--version" ] ; then
    shift
    VERSION=$1
    shift
fi

if [ -f "${1?}.env" ] ; then
  echo using legend
  cat $1.env
  docker run --env-file $1.env -i --rm --net=none microservicesio/plantuml:$VERSION < $1 > "${TMP_PNG}"
else
  echo not legend
  docker run -i --rm --net=none microservicesio/plantuml:$VERSION < $1 > "${TMP_PNG}"
fi

cat "${TMP_PNG}" > ${2?}

rm "${TMP_PNG}"
