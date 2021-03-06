module combine_tb_reg_file_inst_mem();
  
  reg rd_1,rd_2,rd_3,rd_pc,wr_reg_file,wr_pc,rd_inst,wr_inst;
  reg [31:0] data_wr_reg_file,pc_next,inst_wr_data;
  wire [31:0] reg_out1,reg_out2,reg_out3;
  
 // wire [3:0] src1,src2,src3,dest_reg_file;
  wire [31:0] pc_data,inst;
  
  instruction_memory inst_mem_1(.inst_address(pc_data),.inst_read(rd_inst),.inst_write(wr_inst),.inst_write_data(inst_wr_data),.inst_out(inst));
  
  register_32 reg_file(.read_1(rd_1),.read_2(rd_2),.read_3(rd_3),.read_pc(rd_pc),.write(wr_reg_file)
  ,.write_pc(wr_pc),.src1_add(inst[19:16]),.src2_add(inst[3:0]),.src3_add(inst[11:8])
  ,.dest_add(inst[15:12]),.data_write(data_wr_reg_file),.pc_next(pc_next),.pc_data(pc_data)
  ,.out_src1(reg_out1),.out_src2(reg_out2),.out_src3(reg_out3));
  
  initial
  begin
    rd_1=0;
    rd_2=0;
    rd_3=0;
    rd_pc=0;
    wr_reg_file=0;
    wr_pc=0;
    rd_inst=0;
    wr_inst=0;
    data_wr_reg_file=32'd34;
    
    #2rd_pc=1;
    #2rd_pc=0;
      rd_inst=1;
      
    #2rd_inst=0;
      rd_1=1;
      rd_2=1;
      
    #2rd_1=0;
      rd_2=0;
      
  end
  
endmodule
      