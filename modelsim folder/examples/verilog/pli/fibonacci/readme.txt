This example has a simple C algorithm for computing a Fibonacci sequence.  The
C function is called directly by the verilog code through the Verilog PLI
interface.

This PLI example can be used along with the SystemVerilog DPI version in the
examples/systemverilog/dpi/fibonacci directory to examine the differences
between the two interfaces.  The testbench is set up to call this function in
a loop so relative performance can be measured.

For example scripts to build and run a PLI application, see the ../traverse_design
directory.
