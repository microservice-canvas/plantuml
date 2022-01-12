#! /bin/bash -e

TMP_PNG=$(mktemp /tmp/output.png.XXXX)

echo "${TMP_PNG}"

if [ -f "${1?}.env" ] ; then
  echo using legend
  cat $1.env
  docker run --env-file $1.env -i --rm --net=none microservicesio/plantuml:0.2.0.RELEASE < $1 > "${TMP_PNG}"
else
  echo not legend
  docker run -i --rm --net=none microservicesio/plantuml:0.2.0.RELEASE < $1 > "${TMP_PNG}"
fi

cat "${TMP_PNG}" > ${2?}

rm "${TMP_PNG}"
