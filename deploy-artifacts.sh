#! /bin/bash -e

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[  $BRANCH == "master" ]] ; then
  VERSION=BUILD-${CIRCLE_BUILD_NUM?}
elif [[  $BRANCH =~ RELEASE$ ]] ; then
  VERSION=$BRANCH
elif [[  $BRANCH =~ M[0-9]+$ ]] ; then
  VERSION=$BRANCH
elif [[  $BRANCH =~ RC[0-9]+$ ]] ; then
  VERSION=$BRANCH
else
  VERSION=${BRANCH}-${CIRCLE_BUILD_NUM?}
fi

docker login -u ${DOCKER_USER_ID?} -p ${DOCKER_PASSWORD?}

docker tag plantuml:latest microservicesio/plantuml:$VERSION
docker push microservicesio/plantuml:$VERSION
