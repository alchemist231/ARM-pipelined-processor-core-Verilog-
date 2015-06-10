module data_mem(mem_read,mem_write,word_or_byte,address,write_data,out_data);
  
  parameter mem_size=65535;
  input mem_read,mem_write,word_or_byte;
  input [31:0] write_data,address;
  output [31:0] out_data;
  
  wire mem_read,mem_write,word_or_byte;
  wire [31:0] write_data,address;
  reg [31:0] out_data;
  
  reg [7:0] data_mem1[mem_size:0];
  
  initial
  begin
  data_mem1[32'b100101]=8'h12;
  data_mem1[32'b100110]=8'h34;
  data_mem1[32'b100111]=8'h56;
  data_mem1[32'b101000]=8'h78;
  out_data=32'h0;
  end
 /* 
  always@(mem_read)
  begin
    if(mem_read)
      out_data={data_mem1[address],data_mem1[address+1],data_mem1[address+2],data_mem1[address+3]};
  end
  
  always@(mem_write)
  begin
    if(mem_write)
      begin
      data_mem1[address]=write_data[31:24];
      data_mem1[address+1]=write_data[23:16];
      data_mem1[address+2]=write_data[15:8];
      data_mem1[address+3]=write_data[7:0];
      end
  end
   */ 
  
    
  
  always@(mem_read,mem_write,word_or_byte)
  begin
    if(~word_or_byte)     //for word word_byte=0
    begin
      if(mem_read)
        out_data={data_mem1[address],data_mem1[address+1],data_mem1[address+2],data_mem1[address+3]};
      else if(mem_write)
        begin
        data_mem1[address]=write_data[31:24];
        data_mem1[address+1]=write_data[23:16];
        data_mem1[address+2]=write_data[15:8];
        data_mem1[address+3]=write_data[7:0];
        end
      else
        out_data=out_data;
    end
    else
      begin
      if(mem_read)
        out_data={24'b0,data_mem1[address]};
      else if(mem_write)
        data_mem1[address]=write_data[7:0];
      else
        out_data=out_data;
      end
  end  
  
  
endmodule
      
  
  
  