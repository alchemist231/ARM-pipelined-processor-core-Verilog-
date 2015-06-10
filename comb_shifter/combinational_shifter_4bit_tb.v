module combinational_shifter_4bit_tb();
  
  reg [3:0] in_data;
  reg [1:0] shft_amt;
  reg shft_rot;
  wire [3:0] out_data;
  
  combinational_shifter_4bit c1(in_data,shft_amt,shft_rot,out_data);
  
  initial
  begin
    in_data=4'b0010;
    shft_amt=2'b10;
    shft_rot=0;
    
  end
  
endmodule
