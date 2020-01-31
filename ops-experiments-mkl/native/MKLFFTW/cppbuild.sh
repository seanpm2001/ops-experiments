#!/usr/bin/env bash
# Scripts to build and install native C++ libraries
# Adapted from https://github.com/bytedeco/javacpp-presets
set -eu

if [[ -z "$PLATFORM" ]]; then
    pushd ..
    bash cppbuild.sh "$@" MKLFFTW
    popd
    exit
fi

case $PLATFORM in
    linux-x86_64)
        $CMAKE -DCMAKE_BUILD_TYPE=Release \
               -DCMAKE_INSTALL_PREFIX="../.." \
               -DCMAKE_CXX_COMPILER="/usr/bin/g++" \
               -DCMAKE_CUDA_HOST_COMPILER="/usr/bin/g++" \
		-DMKL_LIBRARY_DIR="/opt/intel/lib/intel64/" \
		-DMKL_INCLUDE_DIR="/opt/intel/mkl/include/" \
		-DOMP_LIBRARY_DIR= "/opt/intel/lib/intel64/" ..
        make
        make install
        ;;
    macosx-*)
        echo "TODO"
        ;;
    windows-x86_64)
   $CMAKE -G"NMake Makefiles" \
		-DCMAKE_BUILD_TYPE=Release \
               -DCMAKE_INSTALL_PREFIX="../.." \
     	-DMKL_LIBRARY_DIR="C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/mkl/lib/intel64_win" \
		-DMKL_INCLUDE_DIR="C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/mkl/include" \
		-DOMP_LIBRARY_DIR= "C:/Program Files (x86)/IntelSWTools/compilers_and_libraries/windows/compiler/lib/intel64_win" ..
        nmake
        nmake install 
        ;;
    *)
        echo "Error: Platform \"$PLATFORM\" is not supported"
        ;;
esac


