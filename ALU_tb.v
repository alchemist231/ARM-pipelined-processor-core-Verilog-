module ALU_tb();
  reg in_carry;
  reg [31:0] operand1,operand2;
  reg [3:0] control;
  wire [31:0] out_data;
  wire zero_flag,negative_flag,overflow_flag;
  
  ALU main_ALU(control,operand1,operand2,in_carry,out_data,zero_flag,overflow_flag,negative_flag);
  
  initial
  begin
    //enable=0;
    operand1=32'h00000001;
    operand2=32'h0000000a;
    control=4'b0100;
    
    #4
    control=4'b0001;
    
    #4
    control=4'b0100;
    
    #4 operand1=32'hffffffff;
    operand2=32'h00000001;
    control=4'b0000;
    
    #4 operand1=32'hffffffff;
    operand2=32'hffffffff;
    control=4'b0001;
    
    #4 operand1=32'h0000ffff;
    operand2=32'h00000001;
    control=4'b0100;
    
  end
  
  
  
endmodule
  
    
