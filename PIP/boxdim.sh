#!/bin/bash

vmd -dispdev text << EOF
  source load_membrane.tcl
  set all [atomselect top "all"]
  set minmax [measure minmax \$all]
  set vec [vecsub [lindex \$minmax 1] [lindex \$minmax 0]]
  set outfile [open "boxdim.txt" w]
  puts \$outfile \$vec
  close \$outfile
EOF

