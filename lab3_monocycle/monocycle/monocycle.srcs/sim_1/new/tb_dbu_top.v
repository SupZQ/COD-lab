`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 21:17:22
// Design Name: 
// Module Name: tb_dbu_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_dbu_top;     

// dbu_top Parameters  
parameter PERIOD  = 10;


// dbu_top Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 1 ;
reg   succ                                 = 0 ;
reg   step                                 = 0 ;
reg   m_rf                                 = 0 ;
reg   inc                                  = 0 ;
reg   dec                                  = 0 ;
reg   [2:0]  sel                           = 0 ;

// dbu_top Outputs
wire  [15:0]  led                          ;
wire  [7:0]  an                            ;
wire  [7:0]  seg                           ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD)   rst = 0;
end

dbu_top  u_dbu_top (
    .clk                     ( clk          ),
    .rst                     ( rst          ),
    .succ                    ( succ         ),
    .step                    ( step         ),
    .m_rf                    ( m_rf         ),
    .inc                     ( inc          ),
    .dec                     ( dec          ),
    .sel                     ( sel   [2:0]  ),

    .led                     ( led   [15:0] ),
    .an                      ( an    [7:0]  ),
    .seg                     ( seg   [7:0]  )
);

initial
begin
    //addi $t0,$0,3  00
    repeat(8)
    begin
        #(PERIOD) inc = 1;  //register file t0
        #(PERIOD) inc = 0;
    end

    #(2*PERIOD) step = 1;   //addi $t1,$0,5 t1  04
    #(PERIOD) step = 0;

    #(PERIOD) inc = 1;  //register file,addr=9
    #(PERIOD) inc = 0;

    repeat(2)
    begin
    #(PERIOD) step = 1;   //addi $t2,$0,1和addi $t3,$0,0  08 12
    #(PERIOD) step = 0;
    end
    #(2*PERIOD) step = 1;   
    #(PERIOD) step = 0;     //add  $s0,$t1,$t0 16
    #(PERIOD) sel = 1;  //pc_in
    #(PERIOD) sel = 2;  //pc_out
    #(PERIOD) sel = 3;  //instr
    #(PERIOD) sel = 4;  //rf_rd1
    #(PERIOD) sel = 5;  //rf_rd2
    #(PERIOD) sel = 6;  //alu_y
    
    #(PERIOD) sel = 0;
    repeat(4)
    begin
    #(PERIOD) step = 1;   //执行完lw $t1, 20($0) 20 24 32 36
    #(PERIOD) step = 0;
    end
    #(PERIOD) dec = 1;  //register file t0,addr=8
    #(PERIOD) dec = 0;
    #(PERIOD) sel = 7;  //m_rd

    #(PERIOD) sel = 1;    
    repeat(3)
    begin
    #(PERIOD) step = 1;   //add  $s0,$t1,$t0,lw $s1, 24($0),beq  $s1,$s0,_next2 40 44 48
    #(PERIOD) step = 0;
    end

    #(PERIOD) sel = 0;
    #(PERIOD) m_rf = 1;
    repeat(3)
    begin
    #(PERIOD) step = 1;   //sw   $t3,8($0) 56 60 72
    #(PERIOD) step = 0;
    end

    repeat(6)
    begin
    #(PERIOD) dec = 1;  //DM,addr=2
    #(PERIOD) dec = 0;
    end

    #(PERIOD) sel = 1;
    #(PERIOD) succ = 1; //jump
    #(4*PERIOD) $finish;
end


endmodule
