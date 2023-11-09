#note using just gofr is not enough
#assumes that sel1 and sel2 exists within global scope

if {$sel1 == "" || $sel2 == ""} {
	puts "choose a selection pair within the rdf_script.sh file"
	exit
}

#Set unit cell to the same value over the entire trajectory
proc set_unitcell {a b c {molid top} {alpha 90.0} {beta 90.0} {gamma 90.0}} {
	# <akohlmey 02.07.2003 10:38:17 yello.theochem.ruhr-uni-bochum.de>
	# Copyright (c) 2003 by <Axel.Kohlmeyer@theochem.ruhr-uni-bochem.de>
	
	if {![string compare $molid top]} {
		set molid [molinfo top]
	}

	set n [molinfo $molid get numframes]

	for {set i 0} {$i < $n} {incr i} {
		molinfo $molid set frame $i
		molinfo $molid set {a b c alpha beta gamma} \
			[list $a $b $c $alpha $beta $gamma]
	}
}

# find dimension of box
set all [atomselect top "all"]
set minmax [measure minmax $all]

foreach {min max} $minmax {break}
foreach {xmin ymin zmin} $min {break}
foreach {xmax ymax zmax} $max {break}

#use dimension to determine unit cell for rdf calculation
set set_a [expr $xmax - $xmin]
set set_b [expr $ymax - $ymin]
set set_c [expr $zmax - $zmin]
set_unitcell $set_a $set_b $set_c

set sel1_selection [atomselect top $sel1]
set sel2_selection [atomselect top $sel2]
set gr [measure gofr $sel1_selection $sel2_selection first 0 last -1 step 1 usepbc TRUE]

set outfile [open "gofr_${sel1}_${sel2}.dat" w]
set r [lindex $gr 0]
set gr2 [lindex $gr 1]
set igr [lindex $gr 2]

foreach j $r k $gr2 l $igr {
	puts $outfile "$j $k $l"
}

close $outfile