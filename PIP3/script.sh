#!/bin/bash

ml vmd

cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-x/
vmd -dispdev text -args source velocities.tcl EF-x
exit

cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-y/
vmd -dispdev text -args source velocities.tcl EF-y
exit

cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-z/
vmd -dispdev text -args source velocities.tcl EF-z
exit

# vmd -dispdev text << EOF

# cd/scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-x/
# source velocities.tcl EF-x

# cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-y/
# source velocities.tcl EF-y

# cd /scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-z/
# source velocities.tcl EF-z

# EOF
