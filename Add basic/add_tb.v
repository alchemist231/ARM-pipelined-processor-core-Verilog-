module add_tb();
  reg [3:0] in_1,in_2;
  wire [3:0] out_1;
  wire overflow;
  
  add add1(in_1,in_2,out_1,overflow);
  
  initial
  begin
    in_1=4'b0001;
    in_2=4'b0001;
    
    #10 in_1=4'b0011;
        in_2=4'b0111;
    
    #10 in_1=4'b0111;
        in_2=4'b0111;
        
    #10 in_1=4'b1011;
        in_2=4'b0111;       

  end
  
endmodule

