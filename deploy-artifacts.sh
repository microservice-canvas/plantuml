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

IMAGE=microservicesio/plantuml:$VERSION

echo Pushing image

sudo apt-get update
sudo apt-get install -y jq

SRC_TAG=test-build-${CIRCLE_SHA1?}

# docker manifest inspect is only supported on a Docker cli with experimental cli features enabled

#export DOCKER_CLI_EXPERIMENTAL=enabled

docker buildx imagetools create -t ${IMAGE} \
  $(docker manifest inspect docker.io/microservicesio/plantuml:${SRC_TAG}| jq -r '.manifests[].digest' | xargs -n1 -I XYZ echo microservicesio/plantuml@XYZ)
