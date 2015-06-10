module counter_5bit(reset,clock,current_state);

	input wire clock,reset;
	output wire [4:0] current_state;

	reg [4:0] state;

	assign current_state=state;

	//asynchronous reset
	always@(posedge clock,posedge reset)
	begin
	if(reset)
		begin
		state=0;
		end
	else
		begin
		state=state+1;
		end
	end

endmodule
