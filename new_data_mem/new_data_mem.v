module new_data_mem_tb();
  
  reg mem_read,mem_write;
  reg [31:0] address,write_data;
  wire [31:0] out_data;
  
  data_mem main_data_mem(mem_read,mem_write,address,write_data,out_data);
  
  initial
  begin
    address=32'd1;
    write_data=32'hffff1100;
    mem_read=0;
    mem_write=1;
    
    #2
    mem_read=1;
    mem_write=0;
  end
  
endmodule
  
  
