#!/bin/bash

# This patch is to fix a bug in gmx_MMPBSA which prevents it from detecting gromacs v 5.x

sed -i "s/INPUT\['general'\]\['gmx_path'\] or //g" /home/ec2-user/anaconda3/envs/gmx_MMPBSA/lib/python3.9/site-packages/GMXMMPBSA/utils.py

