`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 08:51:25
// Design Name: 
// Module Name: tb_cpu
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

module tb_cpu;

// cpu Parameters      
parameter PERIOD  = 10;


// cpu Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 1 ;

// cpu Outputs



initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD) rst  =  0;
end

cpu  u_cpu (
    .clk                     ( clk   ),
    .rst                     ( rst   )
);


endmodule
