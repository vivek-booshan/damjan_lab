#!/bin/bash

ml vmd


cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-x/
vmd -args source velocities.tcl EF-x
exit

cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-y/
vmd -args source velocities.tcl EF-y
exit

cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-z/
vmd -args source velocities.tcl EF-z
exit

# vmd << EOF

# cd/scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-x/
# source velocities.tcl EF-x

# cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-y/
# source velocities.tcl EF-y

# cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-z/
# source velocities.tcl EF-z

# EOF
