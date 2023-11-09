#!/bin/bash
vmd -dispdev text << EOF
	source load_membrane.tcl
	set sel1 "resname POT"
	set sel2 "resname POPC"
	
	source rdf_analysis.tcl
	exit
EOF
