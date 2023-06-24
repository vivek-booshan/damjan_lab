proc get_trajectory {} {
    set cwd [file dirname [info script]]
    set nc_count [llength [glob [file join $cwd nc eq.*.nc]]]
    for {set i 1} {$i <= $nc_count} {incr i} {
        mol addfile [file join $cwd nc eq.$i.nc] first 0 last -1 waitfor all
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

