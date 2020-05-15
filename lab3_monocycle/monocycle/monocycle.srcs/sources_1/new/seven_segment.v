`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 19:27:55
// Design Name: 
// Module Name: seven_segment
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
module seven_segment(CLK,Segment_signal,EN,AN,SEG);
input CLK;
input [31:0]Segment_signal;
input [7:0]EN;
output [7:0]AN;
output [7:0]SEG;
wire [7:0]an_1;
wire [3:0]code;

assign AN = an_1 | ~EN;
refresh refresh(CLK,Segment_signal,an_1,code);
MUX_num mux(code,SEG);
endmodule

