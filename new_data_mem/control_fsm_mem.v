module control_fsm_mem(swp,init_state,rd,wr);
  
  input swp;
  input [1:0] init_state;
  output rd,wr;
  
  wire [1:0] init_state;
  reg [1:0] state;
  reg rd,wr,iterator;
  
  initial
  begin
  iterator=0;
  state=2'b00;
  end
  //always
  //state=init_state;
 // always@(initial_state)
  
  always@(state,init_state)
  begin
    if(~iterator)
    begin
    case(state)
      2'b00 :begin
             rd=0;
             wr=0;
             if(init_state[1])
             begin
              if(init_state[0])
                state=2'b10;
              else
                state=2'b01;
             end
            else
              begin
              state=2'b00;
              end
            end
      2'b01 :begin
            rd=1;
            wr=0;
            if(swp)
              state=2'b10;
            else
              iterator=1;
              state=2'b00;
            end
            
      2'b10 :begin
            rd=1;
       
            wr=0;
            iterator=1;
            state=2'b00;
            end
    endcase
  end  //end if
  else
    iterator=0;
  end
  
endmodule
