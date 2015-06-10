module mux_2x1_1bit(in_1,in_2,select_line,out_data);
  input in_1,in_2,select_line;
  output out_data;
  
  wire in_1,in_2,select_line,out_data,out_1,out_2;
  
  and and_1(out_1,in_1,~select_line);
  and and_2(out_2,in_2,select_line);
  or final_or(out_data,out_1,out_2);
  
endmodule
  
  
  
