`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/24 15:31:43
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(
    input   [1:0] ALUOp,
    input   [5:0] funct,
    output  reg [2:0] ALUm
    );
    always @(*)
    begin
        casex({ALUOp,funct})
        8'b00xxxxxx:    ALUm = 3'b000;  //LW,SW,I-ADD
        8'b01xxxxxx:    ALUm = 3'b001;  //BEQ-SUB
        8'b10100000:    ALUm = 3'b000;  //R-ADD
        default:        ALUm = 3'bxxx;  //以后可以继续扩充
        endcase
    end
    

endmodule
