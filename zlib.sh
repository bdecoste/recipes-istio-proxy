#!/bin/bash

set -e

VERSION=1.2.11

if [ "${FETCH}" ]; then
  if [ ! -d "zlib-$VERSION" ]; then
   curl https://github.com/madler/zlib/archive/v"$VERSION".tar.gz -sLo zlib-"$VERSION".tar.gz
   tar xf zlib-"$VERSION".tar.gz
  fi
else
  cp -rf ${RECIPES_DIR}/zlib-"$VERSION" .
  cd zlib-"$VERSION"

  mkdir build
  cd build
  cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX:PATH="$THIRDPARTY_BUILD" ..
  ninja
  ninja install
fi
