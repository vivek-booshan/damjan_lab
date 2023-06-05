#!/bin/bash

# ml vmd

#TODO: add general file finding and auto assignment
TOPFile="step5_input.parm7" 

### LOAD MEMBRANE ### 
vmd << EOF

source load_membrane.tcl

EOF


