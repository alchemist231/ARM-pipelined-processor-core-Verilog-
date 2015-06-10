module mem_wb_pipeline_reg(in_data,out_data,clock);
  
  parameter size=76;
  
  input wire [size-1:0] in_data;
  input wire clock;
  output wire [size-1:0] out_data;
  
  reg [size-1:0] mem_wb_reg;
  
  assign out_data=mem_wb_reg;
  
  always@(posedge clock)
  mem_wb_reg=in_data;
  
endmodule
