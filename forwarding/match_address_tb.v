module match_address_tb();
  
  reg [3:0] in_add,m_add1,m_add2,m_add3;
  reg load;
  wire [2:0] out;
  wire [1:0] mux_sel;
  wire stall;
  
  //match_address m1(in_add,match_add,out);
  
  forwarding_check_logic f1(in_add,m_add1,m_add2,m_add3,load,mux_sel,stall);
 // muxing_forwarding_logic fw1(out,mux_sel);
  
  initial
  
  begin
    load=0;
    in_add=4'd3;
    m_add1=4'd8;
    m_add2=4'd9;
    m_add3=4'd11;
    
   #2
    load=1;
    in_add=4'd3;
    m_add1=4'd8;
    m_add2=4'd3;
    m_add3=4'd11;
    
  #2
    in_add=4'd3;
    m_add1=4'd8;
    m_add2=4'd6;
    m_add3=4'd3;
    
  #2
    in_add=4'd3;
    m_add1=4'd3;
    m_add2=4'd6;
    m_add3=4'd11;
    
  #2
    in_add=4'd3;
    m_add1=4'd3;
    m_add2=4'd3;
    m_add3=4'd11;
  
  #2
    in_add=4'd3;
    m_add1=4'd3;
    m_add2=4'd5;
    m_add3=4'd3;
    
  #2
    in_add=4'd3;
    m_add1=4'd3;
    m_add2=4'd3;
    m_add3=4'd3;
    
    #2
    in_add=4'd3;
    m_add1=4'd8;
    m_add2=4'd3;
    m_add3=4'd3;
    
  end
  
  
endmodule