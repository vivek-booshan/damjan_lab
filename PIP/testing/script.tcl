mol new "../step5_input.parm7"

for {set i 1} {$i <= 10} {incr i} {
	mol addfile "../nc/eq.$i.nc"
}
