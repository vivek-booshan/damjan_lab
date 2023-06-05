#source load_membrane.tcl

set cwd [file dirname [info script]]
set timestep [llength [glob [file join $cwd nc eq.*.nc]]]

# cd ~/repos/damjan_lab/PIP/nc/
# set timestep [llength [glob eq.*.nc]]
# cd ../

set ion "resname POT"
set ion_selection [atomselect top $ion]
set numframes [molinfo top get numframes]
set coord "x"

set name [join $ion "_"]
set outfile [open "${coord}velocity_${name}.dat" w]
unset name

for {set frame 0} {$frame <= $numframes} {incr frame} {

    animate goto $frame
    set current_coords [$ion_selection get $coord]

    if {$frame > 0} {
        animate goto [expr {$frame-1}]
        set prev_coords [$ion_selection get $coord]

        set frame_velocities {}
        foreach current_coord $current_coords prev_coord $prev_coords {
            set dx [expr {[lindex $current_coord] - [lindex $prev_coord]}]
            set velocity [expr {$dx / $timestep}]
            lappend frame_velocities $velocity
        }
    
        puts $outfile $frame_velocities
    }
}