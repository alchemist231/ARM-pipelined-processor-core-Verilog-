module id_alu_pipeline_reg (clock,freeze,exec_control_in,mem_control_in,wb_control_in,rs1_in,rs2_in,rs3_in,rs4_in,
  wb_add_in,base_reg_add_in,imm_12bit_upper_in,imm_12bit_lower_in,exec_control,mem_control,wb_control,rs1,rs2,rs3,
  rs4,wb_add,base_reg_add,imm_12bit_upper,imm_12bit_lower);
  
  parameter exec_control_width=10;
  parameter mem_control_width=7;
  parameter wb_control_width=2;
  
  input wire clock,freeze;
  
  input wire [exec_control_width-1:0] exec_control_in;
  input wire [mem_control_width-1:0] mem_control_in;
  input wire [wb_control_width-1:0] wb_control_in;
  input wire [31:0] rs1_in,rs2_in,rs3_in,rs4_in;
  input wire [3:0] wb_add_in,base_reg_add_in;
  input wire [11:0] imm_12bit_upper_in,imm_12bit_lower_in;
  
  output wire [exec_control_width-1:0] exec_control;
  output wire [mem_control_width-1:0] mem_control;
  output wire [wb_control_width-1:0] wb_control;
  output wire [31:0] rs1,rs2,rs3,rs4;
  output wire [3:0] wb_add,base_reg_add;
  output wire [11:0] imm_12bit_upper,imm_12bit_lower;
  
  reg [exec_control_width-1:0] exec_control_reg;
  reg [mem_control_width-1:0] mem_control_reg;
  reg [wb_control_width-1:0] wb_control_reg;
  reg [31:0] rs1_reg,rs2_reg,rs3_reg,rs4_reg;
  reg [3:0] wb_add_reg,base_reg_add_reg;
  reg [11:0] imm_12bit_upper_reg,imm_12bit_lower_reg;
  
  initial
  begin
    exec_control_reg=0;
    mem_control_reg=0;
    wb_control_reg=0;
    rs1_reg=0;
    rs2_reg=0;
    rs3_reg=0;
    rs4_reg=0;
    wb_add_reg=0;
    base_reg_add_reg=0;
    imm_12bit_upper_reg=0;
    imm_12bit_lower_reg=0;  
  end
  
  assign  exec_control=exec_control_reg,
          mem_control=mem_control_reg,
          wb_control=wb_control_reg,
          rs1=rs1_reg,
          rs2=rs2_reg,
          rs3=rs3_reg,
          rs4=rs4_reg,
          wb_add=wb_add_reg,
          base_reg_add=base_reg_add_reg,
          imm_12bit_upper=imm_12bit_upper_reg,
          imm_12bit_lower=imm_12bit_lower_reg; 
  
  
  always@(posedge clock)
  begin
    if(~freeze)
    begin
    exec_control_reg<=exec_control_in;
    mem_control_reg<=mem_control_in;
    wb_control_reg<=wb_control_in;
    rs1_reg<=rs1_in;
    rs2_reg<=rs2_in;
    rs3_reg<=rs3_in;
    rs4_reg<=rs4_in;
    wb_add_reg<=wb_add_in;
    base_reg_add_reg<=base_reg_add_in;
    imm_12bit_upper_reg<=imm_12bit_upper_in;
    imm_12bit_lower_reg<=imm_12bit_lower_in;
    end
    else
    begin
    exec_control_reg=0;
    mem_control_reg=0;
    wb_control_reg=0;
    rs1_reg=0;
    rs2_reg=0;
    rs3_reg=0;
    rs4_reg=0;
    wb_add_reg=0;
    base_reg_add_reg=0;
    imm_12bit_upper_reg=0;
    imm_12bit_lower_reg=0;
    end
  end
  
endmodule
