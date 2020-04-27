`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/25 19:28:46
// Design Name: 
// Module Name: Register
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


module Register #(parameter N = 32,RST_VALUE = {N{1'b0}})(
    input [N-1:0] in, //输入
    input en,rst,clk, //使能，复位，时钟
    output reg [N-1:0] out
    );
    always @(posedge clk,posedge rst)
        if(rst)
            out <= RST_VALUE;
        else if(en)
            out <= in;
endmodule
