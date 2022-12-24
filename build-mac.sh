#!/bin/bash

NCPUS=$(( $(sysctl -n hw.ncpu) + 1 ))

set -e

make -f Makefile.mac ARCH=arm64 clean
make -f Makefile.mac ARCH=arm64 -j${NCPUS}
make -f Makefile.mac ARCH=x86-64 clean
make -f Makefile.mac ARCH=x86-64 -j${NCPUS}

lipo -create -output build/libispc_texcomp.dylib \
    build/libispc_texcomp_x86-64.dylib \
    build/libispc_texcomp_arm64.dylib
