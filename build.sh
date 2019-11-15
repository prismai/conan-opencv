#!/bin/bash

set -e

conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan -f
conan create . bvnp43/stable \
    -o opencv:contrib=True \
    -o opencv:dc1394=False \
    -o opencv:eigen=False \
    -o opencv:ffmpeg=True \
    -o opencv:freetype=False \
    -o opencv:gflags=False \
    -o opencv:glog=False \
    -o opencv:harfbuzz=False \
    -o opencv:jasper=False \
    -o opencv:openexr=False \
    -o opencv:png=True \
    -o opencv:quirc=False \
    -o opencv:tiff=False \
    -o opencv:webp=False \
    --build outdated
