module register_file_tb();
  
  reg read_1,read_2,read_3,read_pc,write,write_pc;
  reg [3:0] src1_add,src2_add,src3_add,dest_add;
  reg [31:0] data_write,pc_next;
  
  wire [31:0] pc_data,out_src1,out_src2,out_src3;

  
  register_32 register_file (read_1,read_2,read_3,read_pc,write,write_pc,src1_add,src2_add,src3_add,dest_add,data_write,pc_next,pc_data,out_src1,out_src2,out_src3);
  
  initial
  begin
    read_1=0;
    read_2=0;
    read_3=0;
    read_pc=1;
    write=0;
    write_pc=0;
    
    #2
    src1_add=4'd5;
    src2_add=4'd9;
    read_1=1;
    read_2=1;
    read_3=0;
    read_pc=0;
    write=0;
    write_pc=0;
  
    
    #2
    data_write=32'h76543219;
    pc_next=32'h00000004;
    dest_add=4'd5;
    src2_add=4'd9;
    read_1=0;
    read_2=0;
    read_3=0;
    read_pc=0;
    write=1;
    write_pc=1;
    
    
    #2
    src1_add=4'd5;
   // src2_add=4'd9;
    read_1=1;
    read_2=0;
    read_3=0;
    read_pc=1;
    write=0;
    write_pc=0;
    
  end
    
  
  /*
  
  initial
  begin
    clock=0
    
    //Because of starting clock at '0'; data floats at negative edge of clock and latches at positive edge
    #10 data_write=32'h00000001;
    dest_add=4'b0000;
    write=1;
    
    #10 dest_add=4'b0001;
    data_write=32'h00000010;
    write=1;
    
    #10 dest_add=4'b0010;
    data_write=32'h00000011;
    write=1;
    
    #10 dest_add=4'b0011;
    data_write=32'h00000100;
    write=1;
    
    #10 dest_add=4'b0100;
    data_write=32'h00000101;
    write=1;
    
    #10 dest_add=4'b0101;
    data_write=32'h00000110;
    write=1;
    
    #10 dest_add=4'b0110;
    data_write=32'h00000111;
    write=1;
    
    #10 dest_add=4'b0111;
    data_write=32'h00001000;
    write=1;
    
    #10 dest_add=4'b1000;
    data_write=32'h00111111;
    write=1;
    
    #10 dest_add=4'b1001;
    data_write=32'h00000010;
    write=1;
    
    #10 dest_add=4'b1010;
    data_write=32'h00000010;
    write=1;
    
    #10 dest_add=4'b1011;
    data_write=32'h00000010;
    write=1;
    
    #10 dest_add=4'b1100;
    data_write=32'h00000010;
    write=1;
    
    #10 dest_add=4'b1101;
    data_write=32'h00000010;
    write=1;
    
    #10 dest_add=4'b1110;
    data_write=32'h00000010;
    write=1;
    
    #10 dest_add=4'b1111;
    data_write=32'h00000010;
    write=1;
    
    #10 read_1=1;
    read_2=1;
    read_3=1;
    src1_add=4'b0100;
    src2_add=4'b0011;
    src3_add=4'b1001;
    
    #10 src1_add=4'b0000;
    src2_add=4'b0101;
    src3_add=4'b1000;
    
    
    
  end
  
  always
  begin
    #5 clock=~clock;
  end
  
  */
endmodule