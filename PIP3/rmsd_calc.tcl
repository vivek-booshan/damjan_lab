#function to get trajectories
proc get_trajectory {} {
    set nc_count [llength [glob eq.*.nc]]
    for {set i 1} {$i <= $nc_count} {incr i} {
        mol addfile eq.$i.nc
    }
}

#if file not loaded, load file + trajectories
if {[expr 0 == [molinfo num]]} {
    mol new "step5_input.parm7"
    get_trajectory

} else {
    #if file and but not trajectories: load trajectories
    if {[expr 0 == [molinfo top get numframes]]} {
        get_trajectory
    #if file and trajectories: do nothing
    } else {
    }
}

animate goto 0
set num_frames [molinfo top get numframes]

set rmsd_list {}

#set first frame selection to ion and keep as reference
set ref_sel [atomselect top "name CA"]
set traj_sel [atomselect top "name CA"]
#iterate through all frames, get ions, find rmsd w.r.t ref
for {set i 1} {$i < $num_frames} {incr i} {
    
    $traj_sel frame $i
    set rmsd [measure rmsd $ref_sel $traj_sel]
    #append to list
    lappend rmsd_list $rmsd 
}

set min_decimal_places = [string length [expr {floor(min([join $rmsd_list]))}]]
set rmsd_list_cropped = {}
foreach rmsd $rmsd_list {
    set formatted_rmsd [format %.f $min_decimal_places $rmsd]
    lappend rmsd_list_cropped $formatted_rmsd
}
#write list values to file
set outfile [open "rmsd.txt" w]
foreach rmsd $rmsd_list_cropped {
    puts $outfile $rmsd
    puts $outfile "\n"
}

close $outfile