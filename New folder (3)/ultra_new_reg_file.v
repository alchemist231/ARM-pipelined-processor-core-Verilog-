module ultra_new_reg_file(read_1,read_2,read_3,read_4,write,write_pc,reg_update,set_write_bit,
set_reg_update,src1_add,src2_add,src3_add,dest_add,reg_update_data,data_write,pc_next,reg_update_address,
write_back_address,pc_content,out_src1,out_src2,out_src3,out_src4,stall);

input [31:0] data_write,pc_next,reg_update_data;
  input [3:0] src1_add,src2_add,src3_add,dest_add,reg_update_address,write_back_address;
  input read_1,read_2,read_3,read_4,write,write_pc,reg_update,set_write_bit,set_reg_update;
  output [31:0] out_src1,out_src2,out_src3,out_src4,pc_content; // output src3 to be used in case of shift using register content
  output stall;
  
  wire read_1,read_2,read_3,read_4,write,write_pc,reg_update,set_write_bit;
  wire [31:0] data_write,pc_next,reg_update_data;                   
  wire [3:0] src1_add,src2_add,src3_add,dest_add,reg_update_address,write_back_address;    //addresses of register src1,src2,src3
  wire [31:0] out_src1,out_src2,out_src3,out_src4;
  wire [31:0] pc_content;
  wire stall1,stall2,stall3,stall4,stall_pc; 
  
  reg [32:0] temp1,temp2,temp3,temp4,temp5;     // main register file, 33rd bit denotes write/reg_update
  wire stall;
  
  or(stall,stall1,stall2,stall3,stall4,stall_pc);


reg [32:0] reg_file [15:0];

assign pc_content=reg_file[4'd15][31:0];

initial
  begin
    reg_file[4'd1]=33'h00000000;
    reg_file[4'd1]=33'h00000001;
    reg_file[4'd2]=33'h00000001;
    reg_file[4'd3]=33'h00000000;
    reg_file[4'd4]=33'h00000004;
    reg_file[4'd5]=33'h00000005;
    reg_file[4'd6]=33'h00000006;
    reg_file[4'd7]=33'h00000007;
    reg_file[4'd8]=33'h00000008;
    reg_file[4'd9]=33'h00000009;
    reg_file[4'd10]=33'h0000000a;
    reg_file[4'd11]=33'h0000000b;
    reg_file[4'd12]=33'h0000000c;
    reg_file[4'd13]=33'h0000000d;
    reg_file[4'd14]=33'h0000000e;
    reg_file[4'd15]=33'h00000000;
    
    
    end

always@(stall,read_1,src1_add)
begin
  if(read_1)
  temp1=reg_file[src1_add];
  else
  temp1=temp1;
end

always@(stall,read_2,src2_add)
begin
  if(read_2)
  temp2=reg_file[src2_add];
  else
  temp2=temp2;
end

always@(stall,read_3,src3_add)
begin
  if(read_1)
  temp3=reg_file[src3_add];
  else
  temp3=temp3;
end

always@(stall,read_4,dest_add)
begin
  if(read_4)
  temp4=reg_file[dest_add];
  else
  temp4=temp4;
end

assign out_src1=temp1[31:0];
assign out_src2=temp2[31:0];
assign out_src3=temp3[31:0];
assign out_src4=temp4[31:0];

assign stall1=temp1[32];
assign stall2=temp2[32];
assign stall3=temp3[32];
assign stall4=temp4[32];

  
  always@(set_reg_update,src1_add)
  begin
    reg_file[src1_add][32]=set_reg_update;
  end
  
  always@(set_write_bit,dest_add)
  begin
    reg_file[dest_add][32]=set_write_bit;
  end
  
  always@(write,write_back_address,data_write)
  begin
    // introduce an arbiter and use multiple driver resolution function
    if(write)
      begin
        reg_file[write_back_address]={1'b0,data_write};
      end
  end
  
assign stall_pc=reg_file[4'd15][32];

always@(write_pc)
begin
  if(write_pc)
      begin
      temp5=reg_file[4'd15];
      //stall_pc=temp5[32];
      if(~stall_pc)
      reg_file[4'd15]={1'b0,pc_next};
      end
  end

endmodule


