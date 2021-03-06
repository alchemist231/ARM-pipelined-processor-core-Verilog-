module comparator_1_bit_tb();
	
	reg input1,input2,enable;
	wire in1_gr8,in2_gr8,equality;
	//comparator_1_bit c1(.in1(input1),.in2(input2),.enable(enable),.in1_greater(in1_gr8),.in2_greater(in2_gr8),.equal(equality));
	comparator_1_bit c1(enable,input1,input2,in1_gr8,in2_gr8,equality);

	initial
	begin
		input1=0;
		input2=0;
		enable=1;

	#2	input1=1;  //two time units delay
	#2	input2=1;
	#2	input1=0;
	#2 	enable=0;
	end
		

endmodule
