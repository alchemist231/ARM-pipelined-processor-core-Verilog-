module shift_register_8bits(lsb,msb,control,clock,parallel_load,parallel_read);
	
	input wire msb,clock;
	/* control
		00	right shift
		01	left shift
		10	parallel load
	*/
	input wire [1:0] control;
	input wire [7:0] parallel_load;
	output wire lsb;
	output wire [7:0] parallel_read; // just a wired logic, always able to read , not controlled by control signal

	wire [7:0] temp_input_after_mux,temp_latch_output;

	reg [7:0] latch;
	
	mux_4x1_1bit m7(.in1(msb),.in2(temp_latch_output[6]),.in3(parallel_load[7]),.in4(),.sel(control),.out_data(temp_input_after_mux[7]));
	mux_4x1_1bit m6(.in1(temp_latch_output[7]),.in2(temp_latch_output[5]),.in3(parallel_load[6]),.in4(),.sel(control),.out_data(temp_input_after_mux[6]));
	mux_4x1_1bit m5(.in1(temp_latch_output[6]),.in2(temp_latch_output[4]),.in3(parallel_load[5]),.in4(),.sel(control),.out_data(temp_input_after_mux[5]));
	mux_4x1_1bit m4(.in1(temp_latch_output[5]),.in2(temp_latch_output[3]),.in3(parallel_load[4]),.in4(),.sel(control),.out_data(temp_input_after_mux[4]));
	mux_4x1_1bit m3(.in1(temp_latch_output[4]),.in2(temp_latch_output[2]),.in3(parallel_load[3]),.in4(),.sel(control),.out_data(temp_input_after_mux[3]));
	mux_4x1_1bit m2(.in1(temp_latch_output[3]),.in2(temp_latch_output[1]),.in3(parallel_load[2]),.in4(),.sel(control),.out_data(temp_input_after_mux[2]));
	mux_4x1_1bit m1(.in1(temp_latch_output[2]),.in2(temp_latch_output[0]),.in3(parallel_load[1]),.in4(),.sel(control),.out_data(temp_input_after_mux[1]));
	mux_4x1_1bit m0(.in1(temp_latch_output[1]),.in2(0),.in3(parallel_load[0]),.in4(),.sel(control),.out_data(temp_input_after_mux[0]));
		
	// assign wires the latches output value
	assign temp_latch_output[7]=latch[7];
	assign temp_latch_output[6]=latch[6];
	assign temp_latch_output[5]=latch[5];
	assign temp_latch_output[4]=latch[4];
	assign temp_latch_output[3]=latch[3];
	assign temp_latch_output[2]=latch[2];
	assign temp_latch_output[1]=latch[1];
	assign temp_latch_output[0]=latch[0];

	assign lsb=temp_latch_output[0];
	assign parallel_read=temp_latch_output; 

always@(posedge clock)
begin
	// latch value on mux output line to latches; non blocking assignments
	latch[7]<=temp_input_after_mux[7];
	latch[6]<=temp_input_after_mux[6];
	latch[5]<=temp_input_after_mux[5];
	latch[4]<=temp_input_after_mux[4];
	latch[3]<=temp_input_after_mux[3];
	latch[2]<=temp_input_after_mux[2];
	latch[1]<=temp_input_after_mux[1];
	latch[0]<=temp_input_after_mux[0];

end

endmodule

/* Note: msb used instead of "0" , to scale device from 8 bit to 24bit or 32 bit with ease */
