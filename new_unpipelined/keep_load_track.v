module keep_load_track(in_load,clock,load_stat_exec);
  
  input wire in_load,clock;
  output wire load_stat_exec;
  
  reg load_status;
  
  initial
  load_status=0;
  
  assign load_stat_exec=load_status;
  
  always@(posedge clock)
  begin
    load_status<=in_load;
  end
  
endmodule
  
  
    
  
  
