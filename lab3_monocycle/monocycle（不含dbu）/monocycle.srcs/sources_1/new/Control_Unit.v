`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/11 23:48:56
// Design Name: 
// Module Name: Control_Unit
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

module Control_Unit(
    input [5:0] op,
    output RegDst,Jump,Branch,MemtoReg,MemRead,MemWrite,ALUSrc,RegWrite,
    output [2:0] ALUOp  //待实现的指令有限，故直接生成alu控制信号
    );

    parameter add  = 6'b000000;
    parameter addi = 6'b001000;
    parameter lw   = 6'b100011;
    parameter sw   = 6'b101011;
    parameter beq  = 6'b000100;
    parameter j    = 6'b000010;
    //add_op = 000,sub_op = 001
    reg [10:0]  control;
    assign {RegDst,Jump,Branch,MemtoReg,MemRead,MemWrite,ALUSrc,RegWrite,ALUOp}=control;

    always @(op)
    begin
        case(op)
        add : control = 11'b10000001000;
        addi: control = 11'b00000011000;
        lw  : control = 11'b00011011000;
        sw  : control = 11'bx00x0110000;
        beq : control = 11'bx01x0000001;
        j   : control = 11'bx1xx00x0xxx;
        default: control = 11'bxxxxxxxxxx;
        endcase
    end

endmodule


/*
module Control_Unit(
    input [5:0] op,
    output RegDst,Jump,Branch,MemtoReg,MemWrite,ALUSrc,RegWrite,
    output [2:0] ALUOp  //待实现的指令有限，故直接生成alu控制信号
    );

    parameter add  = 6'b000000;
    parameter addi = 6'b001000;
    parameter lw   = 6'b100011;
    parameter sw   = 6'b101011;
    parameter beq  = 6'b000100;
    parameter j    = 6'b000010;
    //add_op = 000,sub_op = 000
    reg [9:0]  control;
    assign {RegDst,Jump,Branch,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp}=control;

    always @(op)
    begin
        case(op)
        add : control = 10'b1000001000;
        addi: control = 10'b0000011000;
        lw  : control = 10'b0001011000;
        sw  : control = 10'bx00x110000;
        beq : control = 10'bx01x000001;
        j   : control = 10'bx1xx0x0xxx;
        default: control = 10'bxxxxxxxxxx;
        endcase
    end

endmodule

*/