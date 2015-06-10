module comparator_1bit(in1,in2,greater,less,equal);
  input in1,in2;
  output greater,less,equal;
  
  wire in1,in2,greater,less,equal;
  
  xnor x1 (equal,in1,in2);
  and g1 (greater,in1,~in2);
  and l1 (less,~in1,in2);
  
endmodule


  
