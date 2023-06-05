proc get_trajectory {} {
    set nc_count [llength [glob eq.$i.nc]]
    for {set i 1} {$i <= $nc_count} {incr i} {
        mol addfile eq.$i.nc
    }
}

# detect if file and/or trajectories already loaded
if {[expr 0 == [molinfo num]]} {
    mol new "step5_input.parm7"
    get_trajectory
} else {
    # if file loaded but not trajectories: load trajectories
    if {[expr 0 == [molinfo top get numframes]]} {
        get_trajectory
    }
    # if file and trajectories: do nothing
}

