#!/bin/bash

. ./buildscripts/compile-options.sh

# compile wrapper around libvpx
export EMCC_WASM_BACKEND=1
emcc \
  $EMCC_COMMON_OPTIONS \
  $EMCC_WASM_OPTIONS \
  $EMCC_NOTHREAD_OPTIONS \
  -s EXPORT_NAME="'OGVDecoderVideoVP8W'" \
  -s EXPORTED_FUNCTIONS="`< src/js/modules/ogv-decoder-video-exports.json`" \
  -Ibuild/wasm/root/include \
  --js-library src/js/modules/ogv-decoder-video-callbacks.js \
  --pre-js src/js/modules/ogv-module-pre.js \
  --post-js src/js/modules/ogv-decoder-video.js \
  -D OGV_VP8 \
  src/c/ogv-decoder-video-vpx.c \
  -Lbuild/wasm/root/lib \
  -lvpx \
  -o build/ogv-decoder-video-vp8-wasm.js
