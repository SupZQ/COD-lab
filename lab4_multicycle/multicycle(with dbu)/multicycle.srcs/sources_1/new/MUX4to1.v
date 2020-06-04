`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/24 11:46:06
// Design Name: 
// Module Name: MUX4to1
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


module MUX4to1 #(parameter WIDTH=32)(
    input [1:0] sel,    //select signal
    input [WIDTH-1:0] d0,d1,d2,d3,
    output reg [WIDTH-1:0] d_out
    );

    always @(*)
    begin
        case(sel)
        2'b00:  d_out = d0;
        2'b01:  d_out = d1;
        2'b10:  d_out = d2;
        2'b11:  d_out = d3;
        endcase
    end
endmodule

