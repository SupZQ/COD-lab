`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 00:35:06
// Design Name: 
// Module Name: pt_write
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


module pt_write
    #(parameter MAX_LEN = 16)
    (
    input clk,rst,
    input full,
    input we,
    output reg [3:0] pt_w
    );    

    always @(posedge clk,posedge rst)
    begin
        if(rst)
            pt_w <= 4'b0000;
        else if(full==0 && we==1)
            pt_w <= (pt_w+1)%MAX_LEN;
        else
            pt_w <= pt_w;
    end
endmodule
