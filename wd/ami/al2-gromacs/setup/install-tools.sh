#!/bin/bash

yum install -y htop

echo "export PATH=/opt/slurm/bin:/opt/intel/mpi/latest/bin:$PATH" >> /home/ec2-user/.bashrc

