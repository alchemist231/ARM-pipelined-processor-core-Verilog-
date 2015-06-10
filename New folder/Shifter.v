module shifter(enable,in_data,shift_amt,control,out_data);
  input enable,control;    // control would be 6th bit of instr. I[5]
  input [31:0] in_data;
  input [31:0] shift_amt;
  output [31:0] out_data;
  
  wire enable,control;
  wire [31:0] in_data;
  wire [31:0] shift_amt;
  reg [31:0] out_data;
  
  always@(in_data,enable,control)
  begin
    if(enable) 
      begin
        if(control)
          begin
           out_data<=in_data>>shift_amt;
          end
        else
          begin
            out_data<=in_data<<shift_amt;
          end 
    end
    else
      begin
        out_data<=out_data;
      end
    end
        
endmodule
