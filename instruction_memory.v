module instruction_memory(inst_address,inst_read,inst_write,inst_write_data,inst_out);
  input [31:0] inst_address,inst_write_data;
  input inst_read,inst_write;
  output [31:0] inst_out;
  
  wire [31:0] inst_address,inst_write_data;
  wire inst_read,inst_write;
  reg [31:0] inst_out;
  
  reg [7:0] inst_mem [31:0];
  
  initial
  begin
    //inst_1 add r5,r1,r2
    
    
    inst_mem[32'h00000000]=8'he0;
    inst_mem[32'h00000001]=8'h81;
    inst_mem[32'h00000002]=8'h30;
    inst_mem[32'h00000003]=8'h02;
    
    inst_mem[32'h00000004]=8'he2;
    inst_mem[32'h00000005]=8'h04;
    inst_mem[32'h00000006]=8'h51;
    inst_mem[32'h00000007]=8'hb8;
    
    inst_mem[32'h00000008]=8'he0;
    inst_mem[32'h00000009]=8'h41;
    inst_mem[32'h0000000a]=8'h70;
    inst_mem[32'h0000000b]=8'h02;
    
    inst_mem[32'h0000000c]=8'he5;
    inst_mem[32'h0000000d]=8'h88;
    inst_mem[32'h0000000e]=8'h60;
    inst_mem[32'h0000000f]=8'h01;
    
    inst_mem[32'h00000010]=8'he7;
    inst_mem[32'h00000011]=8'h91;
    inst_mem[32'h00000012]=8'h81;
    inst_mem[32'h00000013]=8'h09;
    
    inst_mem[32'h00000014]=8'he6;
    inst_mem[32'h00000015]=8'h82;
    inst_mem[32'h00000016]=8'h81;
    inst_mem[32'h00000017]=8'h14;
    
    
    inst_mem[32'h00000018]=8'he0;
    inst_mem[32'h00000019]=8'h12;
    inst_mem[32'h0000001a]=8'h60;
    inst_mem[32'h0000001b]=8'h04;
    
    inst_mem[32'h0000001c]=8'heb;
    inst_mem[32'h0000001d]=8'h85;
    inst_mem[32'h0000001e]=8'h70;
    inst_mem[32'h0000001f]=8'h03;
    
    inst_mem[32'h00000020]=8'hee;
    inst_mem[32'h00000021]=8'h81;
    inst_mem[32'h00000022]=8'h80;
    inst_mem[32'h00000023]=8'h02;
   
   /* 
    inst_mem[32'h00000024]=8'hed;
    inst_mem[32'h00000025]=8'h81;
    inst_mem[32'h00000026]=8'h80;
    inst_mem[32'h00000027]=8'h02;
    
    inst_mem[32'h00000028]=8'hec;
    inst_mem[32'h00000029]=8'h81;
    inst_mem[32'h0000002a]=8'h80;
    inst_mem[32'h0000002b]=8'h02;
    
    */
    /*
    inst_mem[32'h00000000]=8'he0;
    inst_mem[32'h00000001]=8'h81;
    inst_mem[32'h00000002]=8'h30;
    inst_mem[32'h00000003]=8'h02;
    
    inst_mem[32'h00000004]=8'he0;
    inst_mem[32'h00000005]=8'h84;
    inst_mem[32'h00000006]=8'h50;
    inst_mem[32'h00000007]=8'h02;
    
    inst_mem[32'h00000008]=8'he0;
    inst_mem[32'h00000009]=8'h81;
    inst_mem[32'h0000000a]=8'h80;
    inst_mem[32'h0000000b]=8'h02;
    
    inst_mem[32'h0000000c]=8'he0;
    inst_mem[32'h0000000d]=8'h85;
    inst_mem[32'h0000000e]=8'h70;
    inst_mem[32'h0000000f]=8'h03;
    
    inst_mem[32'h00000010]=8'he7;
    inst_mem[32'h00000011]=8'h91;
    inst_mem[32'h00000012]=8'h81;
    inst_mem[32'h00000013]=8'h09;
    */
    
    
    
    
   inst_out={inst_mem[32'h0],inst_mem[32'h1],inst_mem[32'h2],inst_mem[32'h3]}; 
    
    
    
  end
    
  //assign inst_out=(inst_read)?{inst_mem[inst_address],inst_mem[inst_address+1],inst_mem[inst_address+2],inst_mem[inst_address+3]}: inst_out;
  always@(posedge inst_read)
  begin
  if(inst_read)
  begin
   inst_out={inst_mem[inst_address],inst_mem[inst_address+1],inst_mem[inst_address+2],inst_mem[inst_address+3]};
  end
  else
    inst_out=inst_out;
  end
  
  
  always@(inst_write)     // change these always statement to assign statement
  begin
    if(inst_write)
      begin
        inst_mem[inst_address]=inst_write_data[31:24];
        inst_mem[inst_address+1]=inst_write_data[23:16];
        inst_mem[inst_address+2]=inst_write_data[15:8];
        inst_mem[inst_address+3]=inst_write_data[7:0];
      end
  end
  

endmodule