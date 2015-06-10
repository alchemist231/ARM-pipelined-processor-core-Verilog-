module mux_4x1_1bit(in1,in2,in3,in4,select_line,out_data);
  
  input wire in1,in2,in3,in4;
  input wire [1:0] select_line;
  output wire out_data;
  
  wire out1,out2;
  
  mux_2x1_1bit mux1(in1,in2,select_line[0],out1);
  mux_2x1_1bit mux2(in3,in4,select_line[0],out2);
  
  mux_2x1_1bit mux3(out1,out2,select_line[1],out_data);
  
endmodule
  
