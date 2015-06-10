module mux_2x1_24bit_using8bit_mux(in1,in2,sel,out_data);
	
	input wire [23:0] in1,in2;
	input wire sel;
	output wire [23:0] out_data;

	mux_2x1_8bit m2(.in1(in1[23:15]),.in2(in2[23:15]),.sel(sel),.out_data(out_data[23:15]));
	mux_2x1_8bit m1(.in1(in1[14:8]),.in2(in2[14:8]),.sel(sel),.out_data(out_data[14:8]));
	mux_2x1_8bit m0(.in1(in1[7:0]),.in2(in2[7:0]),.sel(sel),.out_data(out_data[7:0]));

endmodule
