module new_data_mem_tb();
  
  wire mem_read,mem_write;
  reg [31:0] address,write_data;
  wire [31:0] out_data;
  
  reg swp;
  reg [1:0] init_state;
  
  data_mem main_data_mem(mem_read,mem_write,address,write_data,out_data);
  
  control_fsm_mem fsm1(swp,init_state,mem_read,mem_write);
  
  initial
  begin
    address=32'd1;
    write_data=32'hffff1100;
    #2 swp=0;
    init_state=2'b11;
    
    #2 swp=0;
    init_state=2'b10;
    
    #2 write_data=32'h00001212;
    swp=1;
    init_state=10;
    
    #2 swp=0;
    init_state=10;
    
   
  end
  
endmodule
  
  


