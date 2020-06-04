`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 19:34:05
// Design Name: 
// Module Name: refresh
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


module refresh(clk,seg_bus,outan,sw);
input clk;
input [31:0]seg_bus;
output reg [7:0]outan;
output reg [3:0]sw;
reg [2:0]state;
reg [14:0]counter;
reg clk_122hz;

always @(posedge clk)
  begin
    counter <= counter + 1'b1;
    clk_122hz <= counter[14];
  end
always @(posedge clk_122hz)
  begin
      state <= state + 1;
  end
always @(*)
  begin
    case(state)
      3'b000:
        begin
          outan = 8'b11111110;
          sw = seg_bus[3:0];
        end
      3'b001:
        begin
          outan = 8'b11111101;
          sw = seg_bus[7:4];
        end
      3'b010:
        begin
          outan = 8'b11111011;
          sw = seg_bus[11:8];
        end
      3'b011:
        begin
          outan = 8'b11110111;
          sw = seg_bus[15:12];
        end
      3'b100:
        begin
          outan = 8'b11101111;
          sw = seg_bus[19:16];
        end
      3'b101:
        begin
          outan = 8'b11011111;
          sw = seg_bus[23:20];
        end
      3'b110:
        begin
          outan = 8'b10111111;
          sw = seg_bus[27:24];
        end
      3'b111:
        begin
          outan = 8'b01111111;
          sw = seg_bus[31:28];
        end
      default:
        outan = 8'b11111111;
    endcase
  end
endmodule

