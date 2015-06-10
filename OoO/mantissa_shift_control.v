module mantissa_shift_control(reset,clock,limiter,gated_clock);	// 32 state 5 bit counter, requiring 5 bit stopping threshold

	input wire clock,reset;
	input wire[4:0] limiter;
	output wire gated_clock;

	wire [4:0] state_matcher;
	wire [4:0] temp_state;
	wire temp_match_signal;	//high denotes exact match
	counter_5bit count_for_left_right_shifts(.reset(reset),.clock(clock),.current_state(state_matcher));
	
	// Matching of limiter and current state
	xnor x4(temp_state[4],limiter[4],state_matcher[4]);
	xnor x3(temp_state[3],limiter[3],state_matcher[3]);
	xnor x2(temp_state[2],limiter[2],state_matcher[2]);
	xnor x1(temp_state[1],limiter[1],state_matcher[1]);
	xnor x0(temp_state[0],limiter[0],state_matcher[0]);

	and a1(temp_match_signal,temp_state[4],temp_state[3],temp_state[2],temp_state[1],temp_state[0]);

	and a2(gated_clock,~temp_match_signal,clock);

endmodule
	
