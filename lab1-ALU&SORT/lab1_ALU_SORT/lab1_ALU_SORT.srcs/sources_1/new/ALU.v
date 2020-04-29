`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC
// Engineer: 
// super king
// Create Date: 2020/04/22 22:09:48
// Design Name: 
// Module Name: alu
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

//输入、输出均视为补码
module alu
    #(parameter WIDTH=32)
    (output reg [WIDTH-1:0] y,
    output reg zf,
    output reg cf,
    output reg of,
    input [WIDTH-1:0] a,b,
    input [2:0] m
    );
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter AND = 3'b010;
    parameter OR = 3'b011;
    parameter XOR = 3'b100;
    always @(*)
      begin
        case(m)
          ADD:
            begin
              {cf,y} = a + b;
              of = (~a[WIDTH-1]&~b[WIDTH-1]&y[WIDTH-1])
                   |(a[WIDTH-1]&b[WIDTH-1]&~y[WIDTH-1]);
            end
          SUB:
            begin
              y  = a - b;
              of = (~a[WIDTH-1]&b[WIDTH-1]&y[WIDTH-1])
                   |(a[WIDTH-1]&~b[WIDTH-1]&~y[WIDTH-1]);
              //a<b 产生借位
              //在输入输出均为补码的情况下 ，cf = y[WIDTH-1] ^ of
              cf = y[WIDTH-1] ^ of;  
            end
          AND:y = a & b;
          OR:y = a | b;
          XOR:y = a ^ b;
          default: //保证完全赋值
            begin y = 32'd0;zf = 0;cf = 0;of = 0; end
        endcase
        zf = ~|y;
      end
endmodule

              //of = (~a[WIDTH-1]&~b[WIDTH-1]&y[WIDTH-1])
              //     |(a[WIDTH-1]&b[WIDTH-1]&~y[WIDTH-1]);
              //a<b 产生借位
              //在输入输出均为补码的情况下 ，cf = y[WIDTH-1] ^ of  
              //
