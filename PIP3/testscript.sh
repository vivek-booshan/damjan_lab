#!bin/bash

vmd -args source test.tcl efx << EOF
exit
EOF
vmd -args source test.tcl efy << EOF
exit
EOF
vmd -args source test.tcl efz << EOF
exit
EOF