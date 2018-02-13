#!/bin/bash

PYINSTALLER_TAG=${1:-v3.3.1}
PYTHON_VERSION=${2:-3.6}
ALPINE_VERSION=${3:-3.7}

REPO="ermescs/pyinstaller-alpine:${PYINSTALLER_TAG}-python${PYTHON_VERSION}-alpine${ALPINE_VERSION}"
echo "Building '${REPO}'"

docker build --pull \
    --build-arg PYTHON_VERSION=${PYTHON_VERSION} \
    --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
    --build-arg PYINSTALLER_TAG=${PYINSTALLER_TAG} \
    -t $REPO .

read -p "Do you want to push '${REPO}' to the Docker public registry? [yN] " answer
case $answer in
    [yY] )
        docker push ${REPO}
        ;;
    * )
        ;;
esac
