#!/bin/bash

PYINSTALLER_TAG=${1:-v3.3.1}
PYTHON_VERSION=${2:-3.6}
ALPINE_VERSION=${3:-3.7}

REPO="six8/pyinstaller-alpine:alpine-${ALPINE_VERSION}-pyinstaller-${PYINSTALLER_TAG}"

docker build --pull \
    --build-arg PYTHON_VERSION=${PYTHON_VERSION} \
    --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
    --build-arg PYINSTALLER_TAG=${PYINSTALLER_TAG} \
    -t $REPO .

docker push $REPO