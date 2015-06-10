module match_address(in_add,match_add,sel);
  
  input wire [3:0] in_add,match_add;
  output wire sel;
  
  wire temp1,temp2,temp3,temp4;
  
  xor x1(temp1,in_add[0],match_add[0]);
  xor x2(temp2,in_add[1],match_add[1]);
  xor x3(temp3,in_add[2],match_add[2]);
  xor x4(temp4,in_add[3],match_add[3]);
  
  and a1(sel,~temp1,~temp2,~temp3,~temp4);
  

  
endmodule
  
