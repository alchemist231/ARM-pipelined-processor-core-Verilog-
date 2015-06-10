module pc_incrementer_tb();
  
  reg [31:0] pc_current;
  reg pc_inc;
  wire [31:0] pc_next;
  
  pc_incrementer pc_inc1(pc_current,pc_inc,pc_next);

  initial
  begin
    pc_inc=0;
    pc_current=32'h00000000;
  end
  
  always
  begin
  #5 pc_inc=~pc_inc;
  end
  
endmodule