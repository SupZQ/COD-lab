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


module alu
    #(parameter WIDTH=32)
    (output reg [WIDTH-1:0] y,
    output reg zf,
    output reg cf,
    output reg of,
    input [WIDTH-1:0] a,b,
    input [2:0] m
    );
    always @(*)
      begin
        case(m)
          000:
            begin
              {cf,y} = a + b;
              of = (~a[WIDTH-1]&~b[WIDTH-1]&y[WIDTH-1])
                    |(a[WIDTH-1]&b[WIDTH-1]&~y[WIDTH-1]);
            end
          001:
            begin
              {cf,y} = a - b;
              of = (~a[WIDTH-1]&b[WIDTH-1]&y[WIDTH-1])
                    |(a[WIDTH-1]&~b[WIDTH-1]&~y[WIDTH-1]);
            end
          010:y = a & b;
          011:y = a | b;
          100:y = a ^ b;
          default:
            begin y = 32'd0;zf = 0;cf = 0;of = 0; end
        endcase
        zf = ~|y;
      end
endmodule
