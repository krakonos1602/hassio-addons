#!/bin/bash

docker buildx build --platform linux/aarch64 --push --tag ghcr.io/krakonos1602/aarch64-hassio-fireflyiii-addon:$FIREFLY_VERSION --build-arg FIREFLY_VERSION=$FIREFLY_VERSION --build-arg BUILD_ARCH=aarch64 ./
docker buildx build --platform linux/amd64 --push --tag ghcr.io/krakonos1602/amd64-hassio-fireflyiii-addon:$FIREFLY_VERSION --build-arg FIREFLY_VERSION=$FIREFLY_VERSION --build-arg BUILD_ARCH=amd64 ./
