#!/bin/bash

# ml vmd

#TODO: add general file finding and auto assignment

### LOAD MEMBRANE ### 

vmd -dispdev text << EOF #cat << EOF > velocity.vmdin

set cwd "/home/vivek/repos/damjan_lab/PIP"
for {set i 1} {\$i <= 10} {incr i} {
  mol addfile "/home/vivek/repos/damjan_lab/PIP/nc/eq.\$i.nc"


  set numframes [molinfo top get numframes]
  set sum 0
  for {set i 0} {\$i <= \$numframes} {incr i} {
      set sum [expr {\$sum + 1}]
  }
  puts \$sum
}
exit
EOF

## Prints 13 ##

###############################################

# vmd -dispdev text -e load_membrane.tcl << EOF
# source velocities.tcl
# exit
# EOF

##################################################
