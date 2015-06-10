module adder_sub_8bit(in1,in2,carry_out,sum,add_sub,carry_in);
	
	input wire [7:0] in1,in2;
	input wire add_sub,carry_in;
	output wire carry_out;
	output wire [7:0] sum;

	wire [7:0] temp_in2,temp_carry_next;
	
	// Manipulate input 2 for subtraction
	xor x7(temp_in2[7],in2,add_sub);
	xor x6(temp_in2[6],in2,add_sub);
	xor x5(temp_in2[5],in2,add_sub);
	xor x4(temp_in2[4],in2,add_sub);
	xor x3(temp_in2[3],in2,add_sub);
	xor x2(temp_in2[2],in2,add_sub);
	xor x1(temp_in2[1],in2,add_sub);
	xor x0(temp_in2[0],in2,add_sub);

	// eight series combination of full adder
	adder_1_bit a0(.x_current(in1),.y_current(temp_in2[0]),.carry_previous(carry_in),.sum_current(sum[0]),.next_carry(temp_carry_next[0]));
	adder_1_bit a1(.x_current(in1),.y_current(temp_in2[1]),.carry_previous(temp_carry_next[0]),.sum_current(sum[1]),.next_carry(temp_carry_next[1]));
	adder_1_bit a2(.x_current(in1),.y_current(temp_in2[2]),.carry_previous(temp_carry_next[1]),.sum_current(sum[2]),.next_carry(temp_carry_next[2]));
	adder_1_bit a3(.x_current(in1),.y_current(temp_in2[3]),.carry_previous(temp_carry_next[2]),.sum_current(sum[3]),.next_carry(temp_carry_next[3]));
	adder_1_bit a4(.x_current(in1),.y_current(temp_in2[4]),.carry_previous(temp_carry_next[3]),.sum_current(sum[4]),.next_carry(temp_carry_next[4]));
	adder_1_bit a5(.x_current(in1),.y_current(temp_in2[5]),.carry_previous(temp_carry_next[4]),.sum_current(sum[5]),.next_carry(temp_carry_next[5]));
	adder_1_bit a6(.x_current(in1),.y_current(temp_in2[6]),.carry_previous(temp_carry_next[5]),.sum_current(sum[6]),.next_carry(temp_carry_next[6]));
	adder_1_bit a7(.x_current(in1),.y_current(temp_in2[7]),.carry_previous(temp_carry_next[6]),.sum_current(sum[7]),.next_carry(temp_carry_next[7]));

	assign carry_out=temp_carry_next[7];

endmodule