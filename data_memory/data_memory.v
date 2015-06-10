module data_memory (data_address,in_data_write,data_read,data_write,out_data);
  input [31:0]data_address,in_data_write;
  input data_read;
  input data_write;
  output out_data;
  
  wire [31:0] data_address,in_data_write;
  wire data_read,data_write;
  reg [31:0] out_data;
  
  reg [7:0] data_mem [31:0];
  
  initial
  begin
    data_mem[32'h00000000]=8'h12;
    data_mem[32'h00000001]=8'h34;
    data_mem[32'h00000002]=8'h56;
    data_mem[32'h00000003]=8'h78;
  end
    
  
  always@(data_read)
  begin
    if(data_read)
      out_data={data_mem[data_address],data_mem[data_address+1],data_mem[data_address+2],data_mem[data_address+3]};
    else
      out_data=out_data;
  end
  
  always@(data_write)
  begin
    if(data_write)
      begin
      data_mem[data_address]=in_data_write[31:24];
      data_mem[data_address+1]=in_data_write[23:16];
      data_mem[data_address+2]=in_data_write[15:8];
      data_mem[data_address+3]=in_data_write[7:0];
      end
      
  end
  
endmodule
        