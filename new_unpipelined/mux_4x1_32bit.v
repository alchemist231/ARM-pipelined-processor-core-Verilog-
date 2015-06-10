module mux_4x1_32bit(in1,in2,in3,in4,select,out_data);
  
  input wire [31:0] in1,in2,in3,in4;
  input wire [1:0] select;
  output wire [31:0] out_data;
  
  wire [31:0] w1,w2;
  
  mux_2x1_32bit mux1(in1,in2,select[0],w1);
  mux_2x1_32bit mux2(in3,in4,select[0],w2);
  
  mux_2x1_32bit mux3(w1,w2,select[1],out_data);
  
  
  
endmodule
      
