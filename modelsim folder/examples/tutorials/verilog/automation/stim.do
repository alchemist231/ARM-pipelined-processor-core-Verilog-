# Copyright 1991-2013 Mentor Graphics Corporation
#
# All Rights Reserved.
#
# THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
# MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.

# setup an oscillator on the CLK input
force clk 1 50  -r 100
force clk 0 100 -r 100

# reset the clock and then count to 100
force reset 1
run 100
if {[examine count] != 0} {
	echo "!!! Error: Reset failed. COUNT is [examine count]."
} else {
	echo "Reset OK. COUNT is [examine count]."
}

force reset 0
run 10000
if {[expr [examine -decimal count] != 100]} {
	echo "!!! Error: Counting to 100 failed. COUNT is [examine count]."
} else {
	echo "Test passed. COUNT is [examine count]."
}
