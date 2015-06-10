module comp_8bit_tb();
	reg [7:0] in1,in2;
	reg en;
	wire grt,less,eq;

	comparator_8_bit c0(in1,in2,en,grt,less,eq);
	
	initial
	begin
	en=1;
	in1=8'b10111001;
	in2=8'b10111001;
	#5 in1=8'b11010011;
	#5 in1=8'b10000000;
	#5 en=0;
	end

endmodule
	
