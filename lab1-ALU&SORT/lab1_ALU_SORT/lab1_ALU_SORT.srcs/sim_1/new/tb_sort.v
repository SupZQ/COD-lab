`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/26 22:31:52
// Design Name: 
// Module Name: tb_sort
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
   
module tb_sort;

// sort Parameters
parameter N = 4;
parameter PERIOD  = 10    ;


// sort Inputs
reg   [N-1:0]  x0                          = 0 ;
reg   [N-1:0]  x1                          = 0 ;
reg   [N-1:0]  x2                          = 0 ;
reg   [N-1:0]  x3                          = 0 ;
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;

// sort Outputs
wire  [N-1:0]  s0                          ;
wire  [N-1:0]  s1                          ;
wire  [N-1:0]  s2                          ;
wire  [N-1:0]  s3                          ;
wire  done                                 ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

sort u_sort (
    .x0                      ( x0    [N-1:0] ),
    .x1                      ( x1    [N-1:0] ),
    .x2                      ( x2    [N-1:0] ),
    .x3                      ( x3    [N-1:0] ),
    .clk                     ( clk           ),
    .rst                     ( rst           ),

    .s0                      ( s0    [N-1:0] ),
    .s1                      ( s1    [N-1:0] ),
    .s2                      ( s2    [N-1:0] ),
    .s3                      ( s3    [N-1:0] ),
    .done                    ( done          )
);

initial
    begin
    rst = 1;
    #PERIOD rst = 0;
    
    #(PERIOD*8) rst = 1;
    #PERIOD rst = 0;
    
    #(PERIOD*8) rst = 1;
    #PERIOD rst = 0;    
    #(PERIOD*8) rst = 1;
    #PERIOD rst = 0;
    end
initial
begin
    x0 = 3;
    x1 = 5;
    x2 = 7;
    x3 = 6;
    
    #(PERIOD*9);
    x0 = 4;
    x1 = 3;
    x2 = 2;
    x3 = 5;

    #(PERIOD*9);
    x0 = 2;
    x1 = -3;
    x2 = -7;
    x3 = 5;

    #(PERIOD*9) 
    x0 = -1;
    x1 = 3;
    x2 = -3;
    x3 = 5;
    
   #(PERIOD*9)
   $finish;
end

endmodule
