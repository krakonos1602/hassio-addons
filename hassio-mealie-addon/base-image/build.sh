#!/bin/bash

wget https://github.com/mealie-recipes/mealie/archive/refs/tags/v$MEALIE_VERSION.tar.gz
tar -zxf v$MEALIE_VERSION.tar.gz

rm v$MEALIE_VERSION.tar.gz

export SUB_PATH=nginxsbpth

cd mealie-$MEALIE_VERSION/frontend && yarn install --non-interactive --frozen-lockfile && yarn generate && cd ../..

docker buildx build --platform linux/aarch64 --push --tag ghcr.io/krakonos1602/aarch64-hassio-mealie-addon:$MEALIE_VERSION --build-arg MEALIE_VERSION=$MEALIE_VERSION --build-arg BUILD_ARCH=aarch64 ./
docker buildx build --platform linux/amd64 --push --tag ghcr.io/krakonos1602/amd64-hassio-mealie-addon:$MEALIE_VERSION --build-arg MEALIE_VERSION=$MEALIE_VERSION --build-arg BUILD_ARCH=amd64 ./

rm -rf mealie-$MEALIE_VERSION