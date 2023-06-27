#!/bin/bash

ml vmd

cwd="/scratch16/adamjan1/booshan/PIP3"
efx="/scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-x"
efz_positive="/scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF+z"
efz_negative="/scratch16/adamjan1/nsultan/MembraneStudy/PIP3/EF-z"

vmd -dispdev text << EOF
 	set cwd [pwd]
	set target_loc $efx
	set field EF-x
 	cd $efx
 	mol new "step5_input.parm7"
 	source [file join \$cwd load_membrane.tcl]
	source [file join \$cwd velocities.tcl]
 	exit
EOF

vmd -dispdev text << EOF
	set cwd [pwd]
	set target_loc $efz_positive
	set field EF+z
	cd $efz_positive
	mol new "step5_input.parm7"
	source [file join \$cwd load_membrane.tcl]
	source [file join \$cwd velocities.tcl]
	exit
EOF

vmd -dispdev text << EOF
	set cwd [pwd]
	set target_loc $efz_negative
	set field EF-z
	cd $efz_negative
	mol new "step5_input.parm7"
	source [file join \$cwd load_membrane.tcl]
	source [file join \$cwd velocities.tcl]
	exit
EOF
