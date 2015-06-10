module comparator_1_bit(enable,in1,in2,in1_greater,in2_greater,equal);

	input enable,in1,in2;
	output in1_greater,in2_greater,equal;
	
	wire enable,in1,in2,in1_greater,in2_greater,equal;
	wire out_xnor;

	and a1(in1_greater,in1,~in2,enable);
	and a2(in2_greater,~in1,in2,enable);
	xnor x1(out_xnor,in1,in2);
	and a3(equal,out_xnor,enable);

endmodule


