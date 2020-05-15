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
    input   [WIDTH-1:0] pc_in,
    output  reg [WIDTH-1:0] pc_out
    );

    always @(posedge clk, posedge rst)
        if(rst)
            pc_out <= 0;
        else
            pc_out <= pc_in;
endmodule
