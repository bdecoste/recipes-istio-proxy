#!/bin/bash

set -e

VERSION=2.1.8-stable

if [ "${FETCH}" ]; then
  if [ ! -d "libevent-release-$VERSION" ]; then
    curl https://github.com/libevent/libevent/archive/release-"$VERSION".tar.gz -sLo libevent-release-"$VERSION".tar.gz
    tar xf libevent-release-"$VERSION".tar.gz
  fi
else
  cp -rf ${RECIPES_DIR}/libevent-release-"$VERSION" .
  cd libevent-release-"$VERSION"

  mkdir build
  cd build

  # libevent defaults CMAKE_BUILD_TYPE to Release
  build_type=Release
  if [[ "${OS}" == "Windows_NT" ]]; then
    # On Windows, every object file in the final executable needs to be compiled to use the
    # same version of the C Runtime Library. If Envoy is built with '-c dbg', then it will
    # use the Debug C Runtime Library. Setting CMAKE_BUILD_TYPE to Debug will cause libevent
    # to use the debug version as well
    # TODO: when '-c fastbuild' and '-c opt' work for Windows builds, set this appropriately
    build_type=Debug
  fi

  cmake -G "Ninja" \
    -DCMAKE_INSTALL_PREFIX="$THIRDPARTY_BUILD" \
    -DEVENT__DISABLE_OPENSSL:BOOL=on \
    -DEVENT__DISABLE_REGRESS:BOOL=on \
    -DCMAKE_BUILD_TYPE="$build_type" \
    ..
  ninja
  ninja install

  if [[ "${OS}" == "Windows_NT" ]]; then
    cp "CMakeFiles/event.dir/event.pdb" "$THIRDPARTY_BUILD/lib/event.pdb"
  fi
fi
