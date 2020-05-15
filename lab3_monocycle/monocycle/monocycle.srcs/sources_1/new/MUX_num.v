`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 19:32:13
// Design Name: 
// Module Name: MUX_num
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




module MUX_num(SW,SEG);
input [3:0]SW;
output reg [7:0]SEG;

always@(*) case(SW)
    16'h0:
      SEG = 8'b1100_0000;
    16'h1:
      SEG = 8'b1111_1001;
    16'h2:
      SEG = 8'b1010_0100;
    16'h3:
      SEG = 8'b1011_0000;
    16'h4:
      SEG = 8'b1001_1001;
    16'h5:
      SEG = 8'b1001_0010;
    16'h6:
      SEG = 8'b1000_0010;
    16'h7:
      SEG = 8'b1111_1000;
    16'h8:
      SEG = 8'b1000_0000;
    16'h9:
      SEG = 8'b1001_0000;
    16'ha:
      SEG = 8'b1000_1000;
    16'hb:
      SEG = 8'b1000_0011;
    16'hc:
      SEG = 8'b1100_0110;
    16'hd:
      SEG = 8'b1010_0001;
    16'he:
      SEG = 8'b1000_0110;
    16'hf:
      SEG = 8'b1000_1110;
    default SEG=8'b1111_1111;
  endcase
endmodule
