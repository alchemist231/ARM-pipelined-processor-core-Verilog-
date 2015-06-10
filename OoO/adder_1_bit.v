module adder_1_bit(x_current,y_current,carry_previous,sum_current,next_carry);

	input wire x_current,y_current,carry_previous;
	output wire sum_current,next_carry;

	wire xor_out_temp,and_temp1,and_temp2;
	
	// Sum= x XOR y XOR c
	xor x1(xor_out_temp,x_current,y_current);
	xor x2(sum_current,xor_out_temp,carry_previous);

	// C'=x.y + C.(x XOR  y)
	and a1(and_temp1,x_current,y_current);
	and a2(and_temp2,xor_out_temp,carry_previous);
	or o1(next_carry,and_temp1,and_temp2);

endmodule
	
	

