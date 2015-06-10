module forwarding_check_logic(in_add,wr1,match_add1,wr2,match_add2,wr3,match_add3,load,rd,mux_sel,stall);
  
  input wire [3:0] in_add,match_add1,match_add2,match_add3;
  input wire load,rd,wr1,wr2,wr3;
  output wire [1:0] mux_sel;
  output wire stall;
  
  wire [2:0] select,select_final;
  wire [1:0] mux_sel1;
  
  match_address m1(in_add,match_add1,select[2]);
  match_address m2(in_add,match_add2,select[1]);
  match_address m3(in_add,match_add3,select[0]);
  
  and sel_wr1(select_final[2],select[2],wr1);
  and sel_wr2(select_final[1],select[1],wr2);
  and sel_wr3(select_final[0],select[0],wr3);
  
  muxing_forwarding_logic mux_gen(select_final,mux_sel1);
  
 and a1(mux_sel[1],mux_sel1[1],rd);
 and a2(mux_sel[0],mux_sel1[0],rd);
  
  and stall_check(stall,load,select_final[2],rd);
  
endmodule


  
  
  
