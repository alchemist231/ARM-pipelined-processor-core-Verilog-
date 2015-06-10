module shifter_rotater(in_data,shift_amt_reg,shift_control,shift_amt_imm,enable,carry_flag,out_data,carry_out_flag);
  input [31:0] in_data,shift_amt_reg;
  input [2:0] shift_control;
  input [4:0] shift_amt_imm;
  input enable,carry_flag;
  output [31:0] out_data;
  output carry_out_flag;
  
  wire [31:0] in_data,shift_amt_reg;
  wire [2:0] shift_control;
  wire [4:0] shift_amt_imm;
  wire enable,carry_flag;
  reg sign_bit;
  reg [31:0] out_data;
  reg carry_out_flag;

  always@(enable)
  begin
    if(enable)
    begin
    case(shift_control)
      3'b000 :begin
              if(shift_amt_imm!=0)
                begin
                  carry_out_flag=in_data[31-shift_amt_imm+1];
                  out_data=in_data<<shift_amt_imm;
                end
              else
                begin
                  carry_out_flag=carry_flag;
                  out_data=in_data;
                end
              end
      3'b001 :begin
              if(shift_amt_reg!=0)
                begin
                  carry_out_flag=in_data[31-shift_amt_reg+1];
                  out_data=in_data<<shift_amt_reg;
                end
              else
                begin
                  carry_out_flag=carry_flag;
                  out_data=in_data;
                end
              end
      3'b010 :begin
              if(shift_amt_imm!=0)
                begin
                  carry_out_flag=in_data[shift_amt_imm-1];
                  out_data=in_data>>shift_amt_imm;
                end
              else
                begin
                  carry_out_flag=carry_flag;
                  out_data=in_data;
                end
              end
      3'b011 :begin
              out_data=in_data>>shift_amt_reg;
              if(shift_amt_reg!=0)
                  carry_out_flag=in_data[shift_amt_reg-1];
              else
                  carry_out_flag=carry_out_flag;
              end
      3'b100 :begin
              sign_bit=in_data[31];
             // out_data={sign_bit[shift_amt_imm-1:0],in_data[31:shift_amt_imm]};
              if(shift_amt_imm)
                  carry_out_flag=in_data[shift_amt_imm-1];
              else
                  carry_out_flag=carry_out_flag;
              end
      3'b101 :begin
              if(|shift_amt_reg[31:5])
                begin
                out_data={32{in_data[31]}}; 
                carry_out_flag=1; 
                end              
              else
                sign_bit=in_data[31];
             //   out_data={sign_bit[shift_amt_reg-1:0],in_data[31:shift_amt_reg]};
                if(shift_amt_reg!=0)
                  carry_out_flag=in_data[shift_amt_reg-1];
                else
                  carry_out_flag=carry_out_flag;
              end
      3'b110 :begin
              if(shift_amt_imm!=0)
                begin
             //     out_data={in_data[shift_amt_imm-1:0],in_data[31:shift_amt_imm]};
                  carry_out_flag=in_data[shift_amt_imm-1];
                end
              else
                begin
                  carry_out_flag=in_data[0];
                  out_data={carry_flag,in_data[31:1]};
                end
              end
      3'b111 :begin
              if(~|shift_amt_reg[31:5])
                begin
             //     out_data={in_data[shift_amt_reg-1:0],in_data[31:shift_amt_reg]};
                  carry_out_flag=in_data[shift_amt_reg-1];            
                end
              end
      endcase
    end
    else
      out_data=out_data;
    end  //end always block
endmodule
              
              
                  
                
              
                  
              
  
  
  
