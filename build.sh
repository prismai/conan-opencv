#!/bin/bash

set -e

conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan -f
conan create . bvnp43/stable \
    -o opencv:ffmpeg=True \
    -o opencv:contrib=True \
    -o opencv:harfbuzz=False \
    -o opencv:freetype=False \
    -o opencv:webp=False \
    -o opencv:tiff=False \
    --build missing
