module instruction_memory_tb();
  reg [31:0] inst_address,inst_write_data;
  reg inst_read,inst_write;
  wire[31:0]inst_out;
  
  instruction_memory inst_mem(inst_address,inst_read,inst_write,inst_write_data,inst_out);
  
  initial
  begin
    inst_write=0;
    /*
    inst_read=0;
    
    inst_write=0;
    #1inst_write_data=32'h11112222;
    inst_write_add=32'h00000003;
    inst_write=1;
    
    #1inst_write=0;
    #1inst_write_data=32'h11110000;
    inst_write_add=32'h00000007;
    inst_write=1;
    
    #1inst_write=0;
    #1inst_write_data=32'h33331212;
    inst_write_add=32'h0000000b;
    inst_write=1;
    
    #2inst_write=0;
    inst_address=32'h00000003;
    inst_read=1;
    
    #2inst_read=0;
    #1
    inst_address=32'h00000007;
    inst_read=1;
    
    #2inst_read=0;
    #1
    inst_address=32'h0000000b;
    inst_read=1;
    
    #2inst_read=0;
    */
    inst_read=0;
    inst_address=32'h00000000;
    #10
    inst_read=1;
    #10inst_read=0;
    inst_address=32'h00000004;
    #10inst_read=1;
    #10inst_read=0;
    inst_address=32'h00000008;
    #10inst_read=1;
    
  end
endmodule
