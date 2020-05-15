`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/11 22:48:50
// Design Name: 
// Module Name: pc
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


module pc #(parameter WIDTH = 32)
    (input  clk,rst,
    input   [WIDTH-1:0] d,
    output  reg [WIDTH-1:0] q
    );

    always @(posedge clk, posedge rst)
        if(rst)
            q <= 0;
        else
            q <= d;
endmodule
