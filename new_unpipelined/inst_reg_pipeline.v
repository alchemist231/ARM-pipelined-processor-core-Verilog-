module inst_reg_pipeline(clock,freeze,inst_in,inst_out);
  
  input wire [31:0] inst_in;
  input wire clock,freeze;
  output wire [31:0] inst_out;
  
  reg [31:0] inst_reg;
  
  initial
  inst_reg=32'he0813002;
  
  assign inst_out=inst_reg;
  
  always@(posedge clock)
  begin
    if(~freeze)
    inst_reg<=inst_in;
  end
  
endmodule
