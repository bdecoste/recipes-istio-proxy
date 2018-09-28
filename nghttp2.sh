#!/bin/bash

set -e

VERSION=1.33.0
SHA256=42fff7f290100c02234ac3b0095852e4392e6bfd95ebed900ca8bd630850d88c

if [ "${FETCH}" ]; then
  if [ ! -d "nghttp2-$VERSION" ]; then
    curl https://github.com/nghttp2/nghttp2/releases/download/v"$VERSION"/nghttp2-"$VERSION".tar.gz -sLo nghttp2-"$VERSION".tar.gz \
      && echo "$SHA256" nghttp2-"$VERSION".tar.gz | sha256sum --check    
    tar xf nghttp2-"$VERSION".tar.gz
  fi
else
  cp -rf ${RECIPES_DIR}/nghttp2-"$VERSION" .
  cd nghttp2-"$VERSION"

  mkdir build
  cd build

  cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="$THIRDPARTY_BUILD" \
    -DCMAKE_INSTALL_LIBDIR="$THIRDPARTY_BUILD/lib" \
    -DENABLE_STATIC_LIB=on \
    -DENABLE_LIB_ONLY=on \
    ..
  ninja
  ninja install
fi
