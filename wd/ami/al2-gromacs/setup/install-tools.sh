#!/bin/bash

yum install -y htop

echo "export PATH=/opt/slurm/bin:$PATH" >> /home/ec2-user/.bashrc

