#!/bin/bash
#

ml vmd

###############################
#### normal settings
###############################

lipid=CHOL
EF=noEF
Ion=K

resname=CHL1
AtomName=O3

sta=100
last=150
skip=50
TOP=step5_input.psf

###############################
#### other settings
###############################

VMDFile=$lipid.$EF.$Ion.vmdin

rawdataUpperx=$lipid.$EF.$Ion.upperx.rawdat
rawdataUppery=$lipid.$EF.$Ion.uppery.rawdat

rawdataLowerx=$lipid.$EF.$Ion.lowerx.rawdat
rawdataLowery=$lipid.$EF.$Ion.lowery.rawdat

selMEM="segname MEMB"

###############################
#### collect data
###############################

cat << EOF > $VMDFile

set outputUPPERx [open "$rawdataUpperx" w]
set outputUPPERy [open "$rawdataUppery" w]

set outputLOWERx [open "$rawdataLowerx" w]
set outputLOWERy [open "$rawdataLowery" w]

package require pbctools

mol new $TOP
for {set x $sta} {\$x <= $last} {incr x} {
mol addfile step7_\$x.nc first 0 last -1 step $skip waitfor all 0
}

animate goto 0
set all [atomselect top "all"]
set sel [atomselect top "$selMEM"]
set com [measure center \$sel weight mass]
\$all moveby [vecinvert \$com]
    
\$all delete
\$sel delete

set UpperIonLipid [atomselect top "resname $resname and name $AtomName and z > 0"]
set UpperIonResID [\$UpperIonLipid get resid]

set LowerIonLipid [atomselect top "resname $resname and name $AtomName and z < 0"]
set LowerIonResID [\$LowerIonLipid get resid]

set UpperLipids [atomselect top "name P and z > 0"]
set UpperLipidsResID [\$UpperLipids get resid]

set LowerLipids [atomselect top "name P and z < 0"]
set LowerLipidsResID [\$LowerLipids get resid]

set numframes [molinfo top get numframes]

pbc unwrap

for {set i 1} {\$i < \$numframes} {incr i} {

	animate goto \$i

    ### Upper CHOLs

	set upper [atomselect top "not water and not ions and resid \$UpperLipidsResID"]
	set upperCOM [measure center \$upper weight mass]
	set upperCOMx [lindex \$upperCOM 0]
	set upperCOMy [lindex \$upperCOM 1]

    foreach resID \$UpperIonResID {

		set lipid [atomselect top "resname $resname and resid \$resID"]
		
		set lipidx [expr {[lindex [lindex [\$lipid get {x y}] 0] 0] - \$upperCOMx}]
		set lipidy [expr {[lindex [lindex [\$lipid get {x y}] 0] 1] - \$upperCOMy}]

		puts -nonewline \$outputUPPERx [format "%.2f " \$lipidx]
		puts -nonewline \$outputUPPERy [format "%.2f " \$lipidy]
	
		\$lipid delete
	}
	
	puts \$outputUPPERx " "
	puts \$outputUPPERy " "

    ### Lower CHOLs

	set lower [atomselect top "not water and not ions and resid \$LowerLipidsResID"]
	set lowerCOM [measure center \$lower weight mass]
	set lowerCOMx [lindex \$lowerCOM 0]
	set lowerCOMy [lindex \$lowerCOM 1]

    foreach resID \$LowerIonResID {

		set lipid [atomselect top "resname $resname and resid \$resID"]
		
		set lipidx [expr {[lindex [lindex [\$lipid get {x y}] 0] 0] - \$lowerCOMx}]
		set lipidy [expr {[lindex [lindex [\$lipid get {x y}] 0] 1] - \$lowerCOMy}]

		puts -nonewline \$outputLOWERx [format "%.2f " \$lipidx]
		puts -nonewline \$outputLOWERy [format "%.2f " \$lipidy]
	
		\$lipid delete
	}
	
	puts \$outputLOWERx " "
	puts \$outputLOWERy " "

    \$lower delete
    \$upper delete

}
close \$outputUPPER
close \$outputLOWER

exit

EOF

vmd -e $VMDFile -dispdev text

rm $VMDFile

python3 DiffusionAnalysis.py

rm $rawdataUpperx
rm $rawdataUppery

rm $rawdataLowerx
rm $rawdataLowery

# mv $rawdataUpper ../../../Diffusion.Position/
# mv $rawdataLower ../../../Diffusion.Position/

