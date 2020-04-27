`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/25 18:54:18
// Design Name: 
// Module Name: MUX3to1
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


module MUX3to1 #(parameter N = 32)(
    input [1:0] m,
    input [N-1:0] d0,d1,d2,
    output reg [N-1:0]  out
    );
    always @(*)
    begin
        case(m)
        2'b00: out = d0;
        2'b01: out = d1;
        2'b10: out = d2;
        2'b11: out = d0;    //m=2'b00无关，任意赋�?�?
        endcase
    end
endmodule
