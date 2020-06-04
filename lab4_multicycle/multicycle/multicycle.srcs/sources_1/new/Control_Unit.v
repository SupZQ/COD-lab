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
    input clk,rst,
    input [5:0] op,
    output PCWriteCond,PCWrite,IorD,MemRead,MemWrite,
    output MemtoReg,IRWrite,RegDst,RegWrite,ALUSrcA,
    output [1:0] ALUSrcB,ALUOp,PCSource
    );
    //instr parameter
    parameter add  = 6'b000000;
    parameter addi = 6'b001000;
    parameter lw   = 6'b100011;
    parameter sw   = 6'b101011;
    parameter beq  = 6'b000100;
    parameter j    = 6'b000010;

    //state parameter
    parameter IF        = 4'b0000;
    parameter ID        = 4'b0001;
    parameter LS_EX     = 4'b0010;
    parameter LW_MEM    = 4'b0011;
    parameter LW_WB     = 4'b0100;
    parameter SW_MEM    = 4'b0101;
    parameter R_EX      = 4'b0110;
    parameter R_WB      = 4'b0111;
    parameter BEQ_EX    = 4'b1000;
    parameter J_EX      = 4'b1001;
    parameter I_EX      = 4'b1010;
    parameter I_WB      = 4'b1011;

    reg [3:0] cur_state,next_state;
    reg [15:0]  control;

    assign {PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,
            RegDst,RegWrite,ALUSrcA,ALUSrcB,ALUOp,PCSource}=control;
    //三段式描述状态机
    always @(posedge clk,posedge rst)
    begin
        if(rst)
            cur_state <= IF;
        else
            cur_state <= next_state;
    end
    //状态转移条件
    always @(*)
    begin
        case(cur_state)
        IF:         next_state = ID;
        ID:     
            case(op)
            add:    next_state = R_EX;
            addi:   next_state = I_EX;
            lw,sw:  next_state = LS_EX;
            beq:    next_state = BEQ_EX;
            j:      next_state = J_EX;
            default:next_state = 4'b0000;
            endcase
        LS_EX:
            case(op)
            lw:     next_state = LW_MEM;
            sw:     next_state = SW_MEM;
            default:next_state = 4'b0000;
            endcase
        LW_MEM:     next_state = LW_WB;
        R_EX:       next_state = R_WB;
        I_EX:       next_state = I_WB;
        LW_WB,SW_MEM,R_WB,I_WB,BEQ_EX,J_EX:
                    next_state = IF;
        default:    next_state = 4'b0000;
        endcase
    end
    //状态输出
    always @(cur_state)
    begin
        case(cur_state)
        IF:     control = 16'b0101001000010000;
        ID:     control = 16'b0000000000110000;
        LS_EX:  control = 16'b0000000001100000;
        LW_MEM: control = 16'b0011000000000000;
        LW_WB:  control = 16'b0000010010000000;
        SW_MEM: control = 16'b0010100000000000;
        R_EX:   control = 16'b0000000001001000;
        R_WB:   control = 16'b0000000110000000;
        I_EX:   control = 16'b0000000001100000;
        I_WB:   control = 16'b0000000010000000;
        BEQ_EX: control = 16'b1000000001000101;
        J_EX:   control = 16'b0100000000000010;
        default:control = 16'b0000000000000000;
        endcase
    end



endmodule
