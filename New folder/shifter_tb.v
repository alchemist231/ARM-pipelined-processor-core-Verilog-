module shifter_tb();
  reg [31:0] in_data;
  reg [4:0] shift_amt;
  reg enable,control;
  wire [31:0] out_data;
    
  shifter sft1(enable,in_data,shift_amt,control,out_data);
  
  initial 
  begin
    in_data=8'h1;
    shift_amt=5'b00010;
    enable=1;
    control=1;
    #5 control=0;
  end
  
endmodule
