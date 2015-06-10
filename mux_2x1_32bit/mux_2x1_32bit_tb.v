module mux_2x1_32bit_tb();
  reg [31:0] in_data1,in_data2;
  reg select;
  wire [31:0] out_data;
  
  mux_2x1_32bit mux1(in_data1,in_data2,select,out_data);
  
  initial
  begin
    in_data1=32'h12345678;
    in_data2=32'h98765432;
    
    #1 select=0;
    
  #2 select=1;
  end
  
endmodule    
