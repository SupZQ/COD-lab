`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/25 18:45:49
// Design Name: 
// Module Name: MUX2to1
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


module MUX2to1 #(parameter WIDTH = 32)(
    input m,
    input [WIDTH-1:0]  d0,d1,
    output [WIDTH-1:0]  out
    );
    assign  out = m ? d1 : d0;
endmodule
