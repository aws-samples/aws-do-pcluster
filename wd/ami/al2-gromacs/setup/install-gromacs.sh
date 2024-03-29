#!/bin/bash

#######################################################################
## Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
## SPDX-License-Identifier: MIT-0                                     #
#######################################################################

# Reference: https://github.com/aws-samples/awsome-hpc/blob/main/scripts/install/gromacs_install.sh

echo ""
echo "Installing gromacs ..."
echo ""

set -e

#GROMACS_DEFAULT_VERSION="v2021.4"
GROMACS_DEFAULT_VERSION="v2023"

GROMACS_URL=https://gitlab.com/gromacs/gromacs.git
MODULES_PATH="/usr/share/Modules/modulefiles"
ENVIRONMENT="intel/2022.2.0;intel/2022.2.0"

# Help Options
show_help() {
    cat << EOF
Usage: ${0##*/} [-h] [-v GROMACS_VERSION]
Do stuff with FILE and write the result to standard output. With no FILE
or when FILE is -, read standard input.

    -h                   display this help and exit
    -v GROMACS_VERSION    GROMACS version
EOF
}

show_default() {
    cat << EOF
No GROMACS Version specified
Using default: ${GROMACS_DEFAULT_VERSION}
EOF
GROMACS_VERSION=${GROMACS_DEFAULT_VERSION}
}

# Parse options
OPTIND=1 # Reset if getopts used previously
if (($# == 0)); then
    show_default
fi

while getopts ":v:h:" opt; do
    case ${opt} in
        v )
            GROMACS_VERSION=$OPTARG
            ;;
        h )
            show_help
            exit 0
            ;;
        * )
            GROMACS_VERSION=${GROMACS_DEFAULT_VERSION}
            ;;
    esac
done


yum install -y \
    environment-modules \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    git \
    hostname \
    make \
    man \
    man-pages \
    cmake3 \
    bsdtar

#Load module
source /etc/profile.d/modules.sh

# Find parent path
PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# Modules function
source ${PARENT_PATH}/modules-functions.sh

#Load compilers
for comp_mpi in $ENVIRONMENT
do

    load_environment $comp_mpi "$DEPENDS_ON"
    GROMACS_PATH="/opt/gromacs/${GROMACS_VERSION}/${compiler_name}/${compiler_version}"

    if [ -d ${GROMACS_PATH} ]; then
        echo "GROMACS already installed in ${GROMACS_PATH}"
        continue
    fi
    # Create build directory in /tmp
    WORKDIR=`mktemp -d -p /tmp -t gromacs_XXXXXXXXXX`
    cd ${WORKDIR}

    echo "Cloning Gromacs release branch"

    git clone -b ${GROMACS_VERSION} ${GROMACS_URL} gromacs_git

    cd gromacs_git
    mkdir -p build
    cd build


    echo "Compiling GROMACS code"
    cmake3 .. \
        -DGMX_BUILD_OWN_FFTW=ON \
        -DREGRESSIONTEST_DOWNLOAD=OFF \
        -DCMAKE_C_COMPILER=mpicc \
        -DCMAKE_CXX_COMPILER=mpicxx \
        -DGMX_MPI=OFF \
        -DGMX_OPENMP=on \
        -DGMX_DOUBLE=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        -DGMXAPI=OFF \
        -DCMAKE_INSTALL_PREFIX=${GROMACS_PATH} \
        -DGMX_SIMD=AVX_512

    make -j
    make install
    make clean

    echo "Compiling GROMACS MPI code"
    cmake3 .. \
        -DGMX_BUILD_OWN_FFTW=ON \
        -DREGRESSIONTEST_DOWNLOAD=OFF \
        -DCMAKE_C_COMPILER=mpicc \
        -DCMAKE_CXX_COMPILER=mpicxx \
        -DGMX_MPI=on \
        -DGMX_OPENMP=on \
        -DGMX_DOUBLE=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        -DGMXAPI=OFF \
        -DCMAKE_INSTALL_PREFIX=${GROMACS_PATH} \
        -DGMX_SIMD=AVX_512

    make -j
    make install

    #Create module file
    mkdir -p ${MODULES_PATH}/gromacs

    cat > ${MODULES_PATH}/gromacs/${GROMACS_VERSION}-${compiler_name}-${compiler_version} << EOF
#%Module

# NOTE: This is an automatically-generated file!
proc ModulesHelp { } {
   puts stderr "This module adds Gromacs v${GROMACS_VERSION} to various paths"
}

module-whatis "Sets up Gromacs v${GROMACS_VERSION} in your environment"

EOF


    for i in ${MODULE_DEPENDENCIES}
    do
        cat >> ${MODULES_PATH}/gromacs/${GROMACS_VERSION}-${compiler_name}-${compiler_version} << EOF
module load ${i}

EOF
    done

    cat >> ${MODULES_PATH}/gromacs/${GROMACS_VERSION}-${compiler_name}-${compiler_version} << EOF
prepend-path PATH "${GROMACS_PATH}/bin"

EOF
    #Clean up
    cd
    rm -rf ${WORKDIR}
done

