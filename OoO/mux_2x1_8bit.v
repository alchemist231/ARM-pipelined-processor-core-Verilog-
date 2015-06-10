module mux_2x1_8bit(in1,in2,sel,out_data);
	
	input wire [7:0] in1,in2;
	input wire sel;
	output [7:0] out_data;

	mux_2x1_1bit m7(.in_1(in1[7]),.in_2(in2[7]),.select_line(sel),.out_data(out_data[7]));
	mux_2x1_1bit m6(.in_1(in1[6]),.in_2(in2[6]),.select_line(sel),.out_data(out_data[6]));
	mux_2x1_1bit m5(.in_1(in1[5]),.in_2(in2[5]),.select_line(sel),.out_data(out_data[5]));	
	mux_2x1_1bit m4(.in_1(in1[4]),.in_2(in2[4]),.select_line(sel),.out_data(out_data[4]));
	mux_2x1_1bit m3(.in_1(in1[3]),.in_2(in2[3]),.select_line(sel),.out_data(out_data[3]));
	mux_2x1_1bit m2(.in_1(in1[2]),.in_2(in2[2]),.select_line(sel),.out_data(out_data[2]));
	mux_2x1_1bit m1(.in_1(in1[1]),.in_2(in2[1]),.select_line(sel),.out_data(out_data[1]));
	mux_2x1_1bit m0(.in_1(in1[0]),.in_2(in2[0]),.select_line(sel),.out_data(out_data[0]));

endmodule
