#!/bin/bash

# ml vmd

#TODO: add general file finding and auto assignment

### LOAD MEMBRANE ### 
vmd << EOF

source load_membrane.tcl
source velocities.tcl

EOF


