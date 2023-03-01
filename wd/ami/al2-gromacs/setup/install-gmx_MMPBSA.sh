#!/bin/bash

#######################################################################
## Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. #
## SPDX-License-Identifier: MIT-0                                     #
#######################################################################

# Reference: https://valdes-tresanco-ms.github.io/gmx_MMPBSA/dev/installation/

# Install gmx_MMPBSA

echo ""
echo "Installing gmx_MMPBSA ..."
echo ""

source /home/ec2-user/.bashrc
echo PATH=$PATH

#Update conda
conda update conda

#Create a new environment and activate it
conda create -n gmx_MMPBSA python=3.9 -y -q
source activate gmx_MMPBSA

#Install mpi4py and AmberTools
conda install -c conda-forge mpi4py=3.1.3 ambertools=21.12 compilers=1.2.0 -y 

# Install updated version of ParmEd
python -m pip install git+https://github.com/Valdes-Tresanco-MS/ParmEd.git@v3.4

# Install PyQt5 required to use the GUI analyzer tool (gmx_MMPBSA_ana). Not needed for HPC
python -m pip install pyqt5

# (Optional) Install GROMACS
#conda install -c conda-forge libhwloc -y
#conda install -c conda-forge ocl-icd -y
#conda uninstall mpich -y
#conda install -c conda-forge openmpi -y 
#conda install -c bioconda -y 
#conda install mpi4py -y

# Instal gmx_MMPBSA
python -m pip install gmx_MMPBSA

