`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/11 23:39:12
// Design Name: 
// Module Name: SHIFT_left
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

//左移两位
module SHIFT_left #(WIDTH = 32)(
    input [WIDTH-1:0] a,
    output [WIDTH-1:0] y
    );

    assign y = (a<<2);
endmodule
