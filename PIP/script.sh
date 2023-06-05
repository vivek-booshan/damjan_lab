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

vmd -dispdev text -e load_membrane.tcl << EOF
source velocities.tcl
exit
EOF

# vmd -e velocity.vmdin -dispdev text
# set ion "resname POT"
# set ion_selection [atomselect top "resname POT"]
# set outfile [open "xvelocity_resname_POT.dat" w]
# set coord "x"

# for {set frame 0} {\$frame <= 100} {incr frame} {

#     animate goto \$frame
#     set current_coords [\$ion_selection get \$coord]
#     puts \$outfile \$current_coords
# }
# exit
