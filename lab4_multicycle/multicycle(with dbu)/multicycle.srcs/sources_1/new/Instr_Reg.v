`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/24 10:54:12
// Design Name: 
// Module Name: Instr_Reg
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


module Instr_Reg(
    input clk,IRWrite,
    input [31:0] d_in,
    output reg [5:0] d_out0,    //op
    output reg [4:0] d_out1,d_out2, //rs,rt
    output reg [15:0] d_out3
    );

    always @(posedge clk)
        if(IRWrite)
            {d_out0,d_out1,d_out2,d_out3} <= d_in;

endmodule
