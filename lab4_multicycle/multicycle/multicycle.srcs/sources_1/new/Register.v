`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/24 11:44:38
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


module Register #(parameter WIDTH=32)(
    input clk,
    input [WIDTH-1:0] d_in,
    output reg [WIDTH-1:0] d_out
    );

    always @(posedge clk)
        d_out <= d_in;

endmodule