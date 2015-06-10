module mux_4x1_1bit_tb();
  
  reg in1,in2,in3,in4;
  reg [1:0] sel;
  wire out;
  
  mux_4x1_1bit m1(in1,in2,in3,in4,sel,out);
  
  initial
  begin
    in1=0;in2=1;in3=1;in4=0;
    sel=2'b0;
    
    #2
    sel=2'b0;
    
    #2
    sel=2'b1;
    
    #2
    sel=2'b10;
    
    #2
    sel=2'b11;
    
  end
  
endmodule
    
    
    
