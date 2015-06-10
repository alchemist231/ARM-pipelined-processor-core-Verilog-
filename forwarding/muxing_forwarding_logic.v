module muxing_forwarding_logic(select_lines,sel);
  
  input wire [2:0] select_lines;
  input wire [1:0] sel;
  
  wire temp1,temp2;
  
  or o1(temp1,select_lines[1],select_lines[0]);
  and a1(sel[1],~select_lines[2],temp1);
  
  and a2(temp2,~select_lines[1],select_lines[0]);
  or o2(sel[0],select_lines[2],temp2);
  
endmodule
  
    
  
