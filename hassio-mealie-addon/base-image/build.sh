#!/bin/bash

wget https://github.com/mealie-recipes/mealie/archive/refs/tags/v$MEALIE_VERSION.tar.gz
tar -zxf v$MEALIE_VERSION.tar.gz

export SUB_PATH=nginxsbpth

cd mealie-$MEALIE_VERSION/frontend && yarn install --non-interactive --frozen-lockfile && yarn generate

docker login ghcr.io -u krakonos1602 --password-stdin

docker buildx build --platform linux/aarch64 --push --tag ghcr.io/krakonos1602/aarch64-hassio-mealie-addon:$MEALIE_VERSION --build-arg MEALIE_VERSION=$MEALIE_VERSION .
