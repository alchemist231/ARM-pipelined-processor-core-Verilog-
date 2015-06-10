module reg_file(clock,read_1,read_2,read_3,read_4,write,write_pc,reg_update,set_write_bit,set_reg_update,src1_add,src2_add,src3_add,dest_add,reg_update_data,data_write,pc_next,reg_update_address,write_back_address,pc_content,out_src1,out_src2,out_src3,out_src4,stall);
  input [31:0] data_write,pc_next,reg_update_data;
  input [3:0] src1_add,src2_add,src3_add,dest_add,reg_update_address,write_back_address;
  input clock,read_1,read_2,read_3,read_4,write,write_pc,reg_update,set_write_bit,set_reg_update;
  output [31:0] out_src1,out_src2,out_src3,out_src4,pc_content; // output src3 to be used in case of shift using register content
  output stall;
  
  wire read_1,read_2,read_3,read_4,write,write_pc,reg_update,set_write_bit;
  wire modified_clock;
  
  wire [31:0] data_write,pc_next,reg_update_data;                   
  wire [3:0] src1_add,src2_add,src3_add,dest_add,reg_update_address,write_back_address;    //addresses of register src1,src2,src3
  reg [31:0] out_src1,out_src2,out_src3,out_src4;
  wire [31:0] pc_content;
  reg stall1,stall2,stall3,stall4;
  wire stall_pc; 
  
 // reg [32:0] temp1,temp2,temp3,temp4,temp5;
  
  reg [32:0]register_file[15:0];      // main register file, 33rd bit denotes write/reg_update
  wire stall;
  wire stall_final;
  
  
  
  
  initial
  begin
    register_file[4'd0]=33'h00000000;
    register_file[4'd1]=33'h00000001;
    register_file[4'd2]=33'h00000001;
    register_file[4'd3]=33'h00000000;
    register_file[4'd4]=33'h00000004;
    register_file[4'd5]=33'h00000005;
    register_file[4'd6]=33'h00000006;
    register_file[4'd7]=33'h00000007;
    register_file[4'd8]=33'h00000008;
    register_file[4'd9]=33'h00000009;
    register_file[4'd10]=33'h0000000a;
    register_file[4'd11]=33'h0000000b;
    register_file[4'd12]=33'h0000000c;
    register_file[4'd13]=33'h0000000d;
    register_file[4'd14]=33'h0000000e;
    register_file[4'd15]=33'h00000000;
    stall1=1'b0;
    stall2=1'b0;
    stall3=1'b0;
    stall4=1'b0;
 //   stall_pc=1'b0;
 //   stall=0;
    out_src1=0;
    out_src2=0;
    out_src3=0;
    out_src4=0;
    $monitor($time,"%b =stall\n",stall);
    $monitor($time,"%b =stall1\n",stall1); 
    end
     
     
    assign pc_content=register_file[4'd15];
    
    or(stall,stall1,stall2,stall3,stall4,stall_pc);
    
    and mod_clk(modified_clock,clock,~stall);
  //  
//    assign stall1=register_file[src1_add][32];
//    assign stall2=register_file[src2_add][32];
//    assign stall3=register_file[src3_add][32];
//    assign stall4=register_file[dest_add][32];
    assign stall_pc=register_file[4'd15][32];
        
    
    always@(posedge clock,reg_update,write)
    begin
      if(reg_update)
         register_file[reg_update_address]={1'b0,reg_update_data};
      if(write)
      begin
        register_file[write_back_address]={1'b0,data_write};
      end
    end
    
    
    always@(negedge clock)
    begin
     
      if(read_1)
        begin
        if(~stall2&~stall3&~stall4&~stall_pc&~stall1)
          begin
          stall1= register_file[src1_add][32];
          register_file[src1_add][32]=set_reg_update;
          end
        out_src1=register_file[src1_add][31:0];
        end
      else if(~stall2&~stall3&~stall4&~stall_pc&~stall1)
          register_file[src1_add][32]=set_reg_update;
        
      
        
      if(read_2)
        begin
        stall2=register_file[src2_add][32];
        out_src2=register_file[src2_add][31:0];
        end
      if(read_3)
        begin
        stall3=register_file[src3_add][32];
        out_src3=register_file[src3_add][31:0];
        end
      
      
      if(read_4)
        begin
        stall4=register_file[dest_add][32];
        if(~stall2&~stall3&~stall4&~stall_pc&~stall1)
          begin
          register_file[dest_add][32]=set_write_bit;
          end
        out_src4=register_file[dest_add][31:0];
        end
      else if(~stall2&~stall3&~stall4&~stall_pc&~stall1)
          register_file[dest_add][32]=set_write_bit; 
      
    end
       
  /*   
  always@(negedge modified_clock)
  begin
      register_file[dest_add][32]=set_write_bit;
      register_file[src1_add][32]=set_reg_update;
  end
   
   */  
        
  always@(write_pc)
  begin
    if(write_pc)
      if(~register_file[4'd15][32])
      register_file[4'd15]={1'b0,pc_next};
  end      
 
//  always@(posedge clock)
//  stall=stall_final;
 
//  
// // assign stall=stall1|stall2|stall3|stall4|stall_pc;
// assign pc_content=register_file[4'd15];
// 
// //and ar(modified_clock,clock,~stall);
//  
//  always@(read_1,src1_add)
//  begin
//    if(read_1)
//      begin
//      temp1=register_file[src1_add];
//      stall1=temp1[32];          // read signal for first register
//        if(~stall1)
//          out_src1=temp1[31:0];
//        else
//          out_src1=out_src1;
//      end
//    else
//      begin
//        out_src1=out_src1;
//        stall1=stall1;
//        //or out_src1<=32'hxxxxxxxx;
//      end
//  end
//  
//  
//  always@(read_2,src2_add)
//  begin
//    if(read_2)
//      begin
//      temp2=register_file[src2_add];
//      stall2=temp2[32];          // read signal for first register
//        if(~stall2)
//          out_src2=temp2[31:0];
//        else
//          out_src2=out_src2;
//      end
//    else
//      begin
//        out_src2=out_src2;
//        stall2=stall2;
//        //or out_src1<=32'hxxxxxxxx;
//      end
//  end
//  
//  
//  
//  always@(read_3,src3_add)
//  begin
//    if(read_3)
//      begin
//      temp3=register_file[src3_add];
//      stall3=temp3[32];          // read signal for first register
//        if(~stall3)
//          out_src3=temp3[31:0];
//        else
//          out_src3=out_src3;
//      end
//    else
//      begin
//        out_src3=out_src3;
//        stall3=stall3;
//        //or out_src1<=32'hxxxxxxxx;
//      end
//  end
//  
//  
//  always@(read_4,dest_add)
//  begin
//    if(read_4)
//      begin
//      temp4=register_file[dest_add];
//      stall4=temp4[32];          // read signal for first register
//        if(~stall4)
//          out_src4=temp4[31:0];
//        else
//          out_src4=out_src4;
//      end
//    else
//      begin
//        out_src4=out_src4;
//        stall4=stall4;
//        //or out_src1<=32'hxxxxxxxx;
//      end
//  end
//  
//  
//  
//  always@(reg_update,reg_update_address,reg_update_data)
//  begin
//    if(reg_update)
//        register_file[reg_update_address]={1'b0,reg_update_data};
//  end
//  
//  always@(negedge clock)
//  begin
//      register_file[dest_add][32]=set_write_bit;
//      register_file[src1_add][32]=set_reg_update;
//  end
//   
//      
// /* 
//  always@(set_reg_update,src1_add)
//  begin
//    register_file[src1_add][32]=set_reg_update;
//  end
//  */
//  
//  always@(write,write_back_address,data_write)
//  begin
//    // introduce an arbiter and use multiple driver resolution function
//    if(write)
//      begin
//        register_file[write_back_address]={1'b0,data_write};
//      end
//  end
//  
//  /*
//  always@(read_pc)
//  begin
//    if(read_pc)
//      begin
//      temp5=register_file[4'd15];
//      stall_pc=temp5[32];
//      if(~stall_pc)
//      pc_content=temp5[31:0];
//      else
//      pc_content=pc_content;
//      end
//    else
//      pc_content=pc_content;
//  end
//  */
//  
//  always@(write_pc)
//  begin
//    if(write_pc)
//      begin
//      temp5=register_file[4'd15];
//      stall_pc=temp5[32];
//      if(~stall_pc)
//      register_file[4'd15]={1'b0,pc_next};
//      end
//  end
      
    
    
   
      
endmodule

    
    
    
    
    
    
  
  
  


