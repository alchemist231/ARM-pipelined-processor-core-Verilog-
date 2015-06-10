module comp_1bit_tb();
  reg [3:0] in1,in2;
  wire out_greater,out_less,out_equal;
  comparator_4bit a(in1,in2,out_greater,out_less,out_equal);
  
  initial begin
    in1=4'b1011;
    in2=4'b1010;
    
    #5
    in1=4'b0110;
    
    #5
    in2=4'b0111;
    
    #5
    in1=4'b0111;
    
  end
  
  //always @(posedge clk)
endmodule
  
  
  
