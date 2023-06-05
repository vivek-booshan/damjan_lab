# get coordinates using selection, desired coordinate 
# and selection name. Then run for numframes
proc get_coord {sel coord numframes selection_name} {
    set name [join $selection_name "_"]

    # ex) xtraj_resname_POT.dat
    set outfile [open "${coord}traj_${name}.dat" w]

    for {set i 0} {$i < $numframes} {incr i} {
        animate goto $i
        # set cropped_coord [crop_list [$sel get $coord]]
        puts $outfile [$sel get $coord]
    }
    close $outfile
}


#still haven't got this to work
#supposed to crop list to min decimal places
proc crop_list {list_to_crop} {
    set min_decimal_places [string length [expr {floor(min($list_to_crop))}]]
    set cropped_list {}
    foreach value $list_to_crop {
        set cropped_value [format %.$min_decimal_places f $value]
        lappend cropped_list $cropped_value
    }
    return $cropped_list
}


source load_membrane.tcl

set valid_coord {"x" "y" "z" "all" "none"}
set coordinates ""
set numframes [molinfo top get numframes]
animate goto 0

while {!([lsearch $valid_coord $coordinates] >= 0)} {
    # puts "Which coordinate do you want to save? (x/y/z/all/none)"
    # set coordinates [string tolower [gets stdin]]
    # puts "please choose a selection"
    # set selection_name [gets stdin]
    # set sel [atomselect top $selection_name]

    set coordinates "x"
    set selection_name "resname POT"
    set sel [atomselect top $selection_name]
    switch $coordinates {
        "x" {
            get_coord $sel "x" $numframes $selection_name
        }
        "y" {
            get_coord $sel "y" $numframes $selection_name
        }
        "z" {
            get_coord $sel "z" $numframes $selection_name
        }
        "all" {
            get_coord $sel "x" $numframes $selection_name
            get_coord $sel "y" $numframes $selection_name
            get_coord $sel "z" $numframes $selection_name
        }
        "none" {
            break
        }
        default {
            puts "Please enter either x/y/z/all/none."
            set coordinates ""
        }
    }
}


