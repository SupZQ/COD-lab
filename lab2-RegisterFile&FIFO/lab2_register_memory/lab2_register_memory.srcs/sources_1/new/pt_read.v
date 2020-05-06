`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 00:34:45
// Design Name: 
// Module Name: pt_read
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


module pt_read
    #(parameter MAX_LEN = 16)
    (
    input clk,rst,
    input empty,
    input re,   //read enable
    input we,   //write enable
    output reg [3:0] pt_r
    );

    always @(posedge clk,posedge rst)
    begin
        if(rst)
            pt_r <= 4'b0000;
        else if({empty,re,we}==3'b010 )
            pt_r <= (pt_r+1)%MAX_LEN;
        else
            pt_r <= pt_r;
    end
    
endmodule
