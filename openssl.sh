#!/bin/bash

set -e

if [ "${FETCH}" ]; then
  if [ ! -d "istio-proxy-openssl" ]; then
    export COMMIT="594194cac55478fd27da2768bbaaa7e809f34a2b"

    git clone https://github.com/bdecoste/istio-proxy-openssl
    (cd istio-proxy-openssl; git reset --hard "$COMMIT")
  fi
  if [ ! -d "envoy-proxy-openssl" ]; then
    export COMMIT="3621f40865adaf71ef94dcc158bbaf53d605308e"

    git clone https://github.com/bdecoste/envoy-proxy-openssl
    (cd envoy-proxy-openssl; git reset --hard "$COMMIT")
  fi
fi

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! openssl recipe $(pwd)"


