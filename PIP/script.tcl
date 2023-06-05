mol new "step5_input.parm7"

for {set i 1} {$i <= 10} {incr i} {
    mol addfile "nc/eq.$i.nc"
}

## if only the top lines, works fine ##

set ion "resname POT"
set ion_selection [atomselect top "resname POT"]
set outfile [open "xvelocity_resname_POT.dat" w]
set coord "x"
set numframes [molinfo top get numframes]

#**********************************************************#
#* something causes line 13 to not get the correct values *#
#**********************************************************#

for {set frame 0} {$frame < $numframes} {incr frame} {
    puts $frame
}
exit