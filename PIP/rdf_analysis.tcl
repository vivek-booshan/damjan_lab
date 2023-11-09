set sel1_selection [atomselect top $sel1]
set sel2_selection [atomselect top $sel2]
set gr [measure gofr $sel1_selection $sel2_selection first 0 last -1 step 1 usepbc TRUE]

set outfile [open "pairwise-rdf_${sel1}_${sel2}.dat" w]
set r [lindex $gr 0]
set gr2 [lindex $gr 1]
set igr [lindex $gr 2]

foreach j $r k $gr2 l $igr {
	puts $outfile "$j $k $l" 
}
close $outfile
