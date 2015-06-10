module comparator_4bit(input_1,input_2,greater,less,equal);
  input [3:0] input_1,input_2;
  output greater,less,equal;
  
  wire [3:0] input_1,input_2;
  wire greater,less,equal;
  wire comp_1_g,comp_1_l,comp_1_e,
       comp_2_g,comp_2_l,comp_2_e,
       comp_3_g,comp_3_l,comp_3_e,
       comp_4_g,comp_4_l,comp_4_e,
       greater_or_1,greater_or_2,greater_or_3,greater_or_4,
       less_or_1,less_or_2,less_or_3,less_or_4;
       
  
  comparator_1bit c1(.in1(input_1[3]),.in2(input_2[3]),.greater(comp_1_g),.less(comp_1_l),.equal(comp_1_e));
  comparator_1bit c2(.in1(input_1[2]),.in2(input_2[2]),.greater(comp_2_g),.less(comp_2_l),.equal(comp_2_e));
  comparator_1bit c3(.in1(input_1[1]),.in2(input_2[1]),.greater(comp_3_g),.less(comp_3_l),.equal(comp_3_e));
  comparator_1bit c4(.in1(input_1[0]),.in2(input_2[0]),.greater(comp_4_g),.less(comp_4_l),.equal(comp_4_e));
  
  or great1(greater,greater_or_1,greater_or_2,greater_or_3,greater_or_4);
  or less1(less,less_or_1,less_or_2,less_or_3,less_or_4);
  
  assign greater_or_1=comp_1_g;
  and a1(greater_or_2,comp_1_e,comp_2_g);
  and a2(greater_or_3,comp_1_e,comp_2_e,comp_3_g);
  and a3(greater_or_4,comp_1_e,comp_2_e,comp_3_e,comp_4_g);
  
  assign less_or_1=comp_1_l;
  and a4(less_or_2,comp_1_e,comp_2_l);
  and a5(less_or_3,comp_1_e,comp_2_e,comp_3_l);
  and a6(less_or_4,comp_1_e,comp_2_e,comp_3_e,comp_4_l);
  
  and a7(equal,comp_1_e,comp_2_e,comp_3_e,comp_4_e);
  
endmodule
  
  
  


  
  
