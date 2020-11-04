#!/bin/bash -e

IMG=${USER}/che-node
VERSION=buster
TAG=${IMG}:${VERSION}

echo "Building image"
cd ./arbitrary-users-patch

docker build --build-arg=FROM_IMAGE=node:buster --tag=${TAG} .

## Local Test Command (once running, execute 
## `docker exec -it local-che-test bash -l` 
## to access container shell for validation)
# docker run -it --rm --name=local-che-test jglanz/che-node:buster

docker push ${TAG}