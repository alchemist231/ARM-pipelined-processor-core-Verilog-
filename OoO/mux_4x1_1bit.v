module mux_4x1_1bit(in1,in2,in3,in4,sel,out_data);
	
	input wire in1,in2,in3,in4;
	input wire [1:0] sel;
	output wire out_data;

	wire [1:0] temp_out_mux;

	mux_2x1_1bit m1(.in_1(in1),.in_2(in2),.select_line(sel[0]),.out_data(temp_out_mux[0]));
	mux_2x1_1bit m2(.in_1(in3),.in_2(in4),.select_line(sel[0]),.out_data(temp_out_mux[1]));
	mux_2x1_1bit m_2nd_layer(.in_1(temp_out_mux[0]),.in_2(temp_out_mux[1]),.select_line(sel[1]),.out_data(out_data));

endmodule
	
