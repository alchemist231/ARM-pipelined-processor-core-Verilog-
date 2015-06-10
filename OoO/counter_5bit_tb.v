module counter_tb();
	
	reg clk,rst;
	wire [4:0] state;

	counter_5bit c1(.reset(rst),.clock(clk),.current_state(state));

	initial
	begin
	rst=0;
	clk=0;
	#5 rst=1;
	#20 rst=0;
	#40 rst=1;
	#10 rst=0;
	#70 rst=1;
	end

	always
	begin
	#5 clk=~clk;
	end
endmodule


