module pc_incrementer_tb();
  reg [31:0] pc_current;
  reg pc_increment;
  wire [31:0] pc_next;
  
  pc_incrementer pc_increment1(pc_current,pc_increment,pc_next);
  
  initial
  begin
    pc_increment=0;
    pc_current=32'h00001000;
    #1pc_increment=1;
    #1pc_increment=0;
    #1pc_increment=1;
    #1pc_increment=0;
    #1pc_increment=1;
    
  end
endmodule
  
