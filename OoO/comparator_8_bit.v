module comparator_8_bit(in1,in2,en,in1_greater,in2_greater,equal);
	
	parameter width=8;
	input [width-1:0] in1,in2;
	input en;
	output in1_greater,in2_greater,equal;

	wire [width-1:0] in1,in2,en,in1_grt,in2_grt,equal_vector;	// even considering the intermediates as vector
	wire enable,in1_greater,in2_greater,equal;
	
	comparator_1_bit c7(.in1(in1[7]),.in2(in2[7]),.enable(en),.in1_greater(in1_grt[7]),.in2_greater(in2_grt[7]),.equal(equal_vector[7]));
	comparator_1_bit c6(.in1(in1[6]),.in2(in2[6]),.enable(equal_vector[7]),.in1_greater(in1_grt[6]),.in2_greater(in2_grt[6]),.equal(equal_vector[6]));
	comparator_1_bit c5(.in1(in1[5]),.in2(in2[5]),.enable(equal_vector[6]),.in1_greater(in1_grt[5]),.in2_greater(in2_grt[5]),.equal(equal_vector[5]));
	comparator_1_bit c4(.in1(in1[4]),.in2(in2[4]),.enable(equal_vector[5]),.in1_greater(in1_grt[4]),.in2_greater(in2_grt[4]),.equal(equal_vector[4]));
	comparator_1_bit c3(.in1(in1[3]),.in2(in2[3]),.enable(equal_vector[4]),.in1_greater(in1_grt[3]),.in2_greater(in2_grt[3]),.equal(equal_vector[3]));
	comparator_1_bit c2(.in1(in1[2]),.in2(in2[2]),.enable(equal_vector[3]),.in1_greater(in1_grt[2]),.in2_greater(in2_grt[2]),.equal(equal_vector[2]));
	comparator_1_bit c1(.in1(in1[1]),.in2(in2[1]),.enable(equal_vector[2]),.in1_greater(in1_grt[1]),.in2_greater(in2_grt[1]),.equal(equal_vector[1]));
	comparator_1_bit c0(.in1(in1[0]),.in2(in2[0]),.enable(equal_vector[1]),.in1_greater(in1_grt[0]),.in2_greater(in2_grt[0]),.equal(equal_vector[0]));

	//assign final outputs to independent vectors
	assign equal=equal_vector[0];
	or or_in1_greater(in1_greater,in1_grt[7],in1_grt[6],in1_grt[5],in1_grt[4],in1_grt[3],in1_grt[2],in1_grt[1],in1_grt[0]);
	or or_in2_greater(in2_greater,in2_grt[7],in2_grt[6],in2_grt[5],in2_grt[4],in2_grt[3],in2_grt[2],in2_grt[1],in2_grt[0]);

endmodule
	
