#!/bin/bash

# ml vmd

#TODO: add general file finding and auto assignment

### LOAD MEMBRANE ### 

# vmd -dispdev text << EOF #cat << EOF > velocity.vmdin

# source load_membrane.tcl

# set numframes [molinfo top get numframes]
# set sum 0
# for {set i 0} {\$i <= \$numframes} {incr i} {
#     set sum [expr {\$sum + 1}]
# }
# puts \$sum
# exit
# EOF

## Prints 13 ##

###############################################

vmd -dispdev text -e load_membrane.tcl << EOF
source velocities.tcl
exit
EOF

##################################################
