#!bin/bash

ml vmd

echo "Hello World"

vmd -dispdev text << EOF
set sum 0
for {set i 0} {$i < 100} {incr i} {
  set sum [expr $i + 1]
}
EOF