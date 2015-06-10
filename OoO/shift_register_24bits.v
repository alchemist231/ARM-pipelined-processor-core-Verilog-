module shift_register_24bits(lsb,msb,control,clock,parallel_load,parallel_read);

	input wire msb,clock;
	input wire [1:0] control;
	/* control
		00	right shift
		01	left shift
		10	parallel load
	*/
	input wire [23:0] parallel_load;
	output wire lsb;
	output wire [23:0] parallel_read;
	
	wire [1:0] temp_lsb_msb;

	shift_register_8bits s2(.lsb(temp_lsb_msb[1]),.msb(msb),.control(control),.clock(clock),.parallel_load(parallel_load[23:15]),.parallel_read(parallel_read[23:15]));
	shift_register_8bits s1(.lsb(temp_lsb_msb[0]),.msb(temp_lsb_msb[1]),.control(control),.clock(clock),.parallel_load(parallel_load[14:8]),.parallel_read(parallel_read[14:8]));
	shift_register_8bits s0(.lsb(lsb),.msb(temp_lsb_msb[0]),.control(control),.clock(clock),.parallel_load(parallel_load[7:0]),.parallel_read(parallel_read[7:0]));
	
endmodule
