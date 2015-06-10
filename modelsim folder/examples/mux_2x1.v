module mux_2x1(in_data1,in_data2,select_ctrl,out_data);
  input [31:0] in_data1,in_data2;
  input select_ctrl;
  output [31:0] out_data;
  
  wire [31:0] in_data1,in_data2;
  wire select_ctrl;
  reg [31:0] out_data;
  
  assign out_data=(select_ctrl)
