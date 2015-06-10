module tb_tr();
  
  reg [25:0] in1;
  wire [31:0] out1;
  
  tr_concat t1(in1,out1);
  
  initial
  begin
    in1=26'b10000000000000000000000010;
    
    #5
    in1=26'b01000000000000000000001010;
  end
  
endmodule
