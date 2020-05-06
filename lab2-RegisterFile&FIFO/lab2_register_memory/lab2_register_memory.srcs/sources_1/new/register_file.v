`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/05 15:01:45
// Design Name: 
// Module Name: register_file
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


module register_file    //32×WIDTH寄存器堆
    #(parameter WIDTH = 32) //数据宽度
    (
    input clk,   //时钟，上升沿有效
    input [4:0] ra0, //读端口0地址
    output [WIDTH-1:0]  rd0,    //读端口0数据
    input [4:0] ra1, //读端口1地址
    output [WIDTH-1:0]  rd1,    //读端口1数据
    input [4:0] wa, //写端口地址
    input we,   //写使能，高电平有效
    input [WIDTH-1:0]  wd   //写端口数据    
    );

    parameter  NUM = 32;    //寄存器数量
    reg [WIDTH-1:0] REG_FILE [0:NUM-1]; //寄存器堆
    integer i;

    initial
    for(i = 0;i < NUM;i = i + 1)
        REG_FILE[i]=0;

    assign  rd0 = REG_FILE[ra0];
    assign  rd1 = REG_FILE[ra1];
    
    always @(posedge clk)
    begin
        if(we)
            REG_FILE[wa] <= wd;
        REG_FILE[0] <= 0;
    end
endmodule
