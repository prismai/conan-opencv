#!/bin/bash
set -euxo pipefail

PLATFORM=""
CONAN_EXTRA_FLAGS=""

parse_cmd_line()
{
    for i in "$@"
    do
    case $i in
        -p=*|--p=*|-platform=*|--platform=*)
        PLATFORM=${i#*=};;
        *)
        ;;
    esac
    done
}

parse_cmd_line $@

if [ "$PLATFORM" == "ios" ]; then
    IOS_PROFILE=~/.conan/profiles/ios_profile
    [ -f ${IOS_PROFILE} ] && rm ${IOS_PROFILE}
    echo "include(default)
[settings]
os=iOS
os_build=Macos
arch=armv8
arch_build=x86_64
compiler=apple-clang
build_type=Release
os.version=12.1
[build_requires]
darwin-toolchain/1.0.4@theodelrieu/stable
[env]" > ${IOS_PROFILE}
    CONAN_EXTRA_FLAGS="-p ios_profile"
fi

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
    ${CONAN_EXTRA_FLAGS}
