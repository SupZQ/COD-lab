`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 13:28:52
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


module MUX2to1 #(parameter N = 4)(
    input m,
    input [N-1:0]  d0,d1,
    output [N-1:0]  out
    );
    assign  out = m ? d1 : d0;
endmodule
