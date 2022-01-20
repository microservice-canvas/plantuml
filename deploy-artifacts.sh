#! /bin/bash -e

BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[  $BRANCH == "master" ]] ; then
  TARGET_TAG=BUILD-${CIRCLE_BUILD_NUM?}
elif [[  $BRANCH =~ RELEASE$ ]] ; then
  TARGET_TAG=$BRANCH
elif [[  $BRANCH =~ M[0-9]+$ ]] ; then
  TARGET_TAG=$BRANCH
elif [[  $BRANCH =~ RC[0-9]+$ ]] ; then
  TARGET_TAG=$BRANCH
else
  TARGET_TAG=${BRANCH}-${CIRCLE_BUILD_NUM?}
fi

docker login -u ${DOCKER_USER_ID?} -p ${DOCKER_PASSWORD?}

TARGET_IMAGE=microservicesio/plantuml:$TARGET_TAG

SRC_TAG=test-build-${CIRCLE_SHA1?}

echo Retagging $SRC_TAG $TARGET_IMAGE

SOURCES=$(docker manifest inspect docker.io/microservicesio/plantuml:${SRC_TAG} | \
jq -r '.manifests[].digest  | sub("^"; "docker.io/microservicesio/plantuml@")')

docker buildx imagetools create -t ${TARGET_IMAGE} $SOURCES
