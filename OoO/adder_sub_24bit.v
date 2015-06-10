module adder_sub_24bit(in1,in2,carry_previous,sum_bits,carry_out,add_sub);

	input wire [23:0] in1,in2;
	input wire carry_previous,add_sub;
	output wire [23:0] sum_bits;
	output wire carry_out;

	wire [2:0] temp_carry;

	//instantiating three 8 bit adders , previous carry is add_sub signal supplied to first block
	adder_sub_8bit a0(.in1(in1[7:0]),.in2(in2[7:0]),.carry_out(temp_carry[0]),.sum(sum_bits[7:0]),.add_sub(add_sub),.carry_in(carry_previous));
	adder_sub_8bit a1(.in1(in1[14:8]),.in2(in2[14:8]),.carry_out(temp_carry[1]),.sum(sum_bits[7:0]),.add_sub(add_sub),.carry_in(temp_carry[0]));
	adder_sub_8bit a2(.in1(in1[23:15]),.in2(in2[23:15]),.carry_out(temp_carry[1]),.sum(sum_bits[7:0]),.add_sub(add_sub),.carry_in(temp_carry[1]));

	assign carry_out=temp_carry[2];

endmodule
