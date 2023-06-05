proc get_velocity {nc_count ion_selection coord outfile numframes} {

	for {set frame 0} {$frame <= $numframes} {incr frame} {
		animate goto $frame
		set current_coords [$ion_selection get $coord]

		if {$frame > 0} {
			animate goto [expr {$frame-1}]
			set prev_coords [$ion_selection get $coord]

			set frame_velocities {}
			foreach current_coord $current_coords prev_coord $prev_coords {
				set dx [expr {[lindex $current_coord] - [lindex $prev_coord]}]
				set velocity [expr {$dx / $nc_count}]
				lappend frame_velocities $velocity
			}

			puts $outfile $frame_velocities
		}
	}
}

set cwd [file dirname [info script]]
set nc_count [llength [glob file join $cwd nc eq.*.nc]]

for {set i 1} {$i <= $nc_count} {incr i} {
	mol addfile [file join $cwd nc eq.$i.nc]

	set ion "resname POT"
	set ion_selection [atomselect top $ion]
	set numframes [molinfo top get numframes]

	set coord "x"

	set name [join $ion "_"]
	set outfile [open "${coord}velocity_${name}.dat" w]

	get_velocity $nc_count $ion_selection $coord $outfile $numframes
}

