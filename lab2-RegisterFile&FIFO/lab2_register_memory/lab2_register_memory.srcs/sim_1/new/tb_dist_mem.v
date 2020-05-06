`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/05 21:17:24
// Design Name: 
// Module Name: tb_dist_mem
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


module tb_dist_mem;

// blk_mem Parameters
parameter PERIOD = 10; 

// blk_mem Inputs
reg   clk                                  = 0 ;
reg   [3:0]  a                             = 0 ;
reg   [7:0] d                              = 0 ;
reg   we                                   = 0 ;

// blk_mem Outputs
wire  [7:0] spo                                ;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    forever #PERIOD we=~we;
end

dist_mem  u_dist_mem (
    .clk                     ( clk              ),
    .a                       ( a    [3:0]       ),
    .d                       ( d    [7:0]       ),
    .we                      ( we               ),
    .spo                     ( spo  [7:0]       )
);

initial
begin
    repeat(3) begin
    a   = $random%16;
    d   = $random%256;
    #(PERIOD*2);
    end

    repeat(3)
    begin
    a   = $random%16;
    d   = $random%256;
    #(PERIOD*2);
    end
    a = 9;
    #(PERIOD*2);
    $finish;
end



endmodule
