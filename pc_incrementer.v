module pc_incrementer(pc_current,pc_next);
  input [31:0] pc_current;
  output [31:0] pc_next;
  
  wire [31:0] pc_current;
  wire [31:0] pc_next;
  
  //later include exception handling if overflow in pc address????
  
  assign pc_next=pc_current+4;
  
endmodule
