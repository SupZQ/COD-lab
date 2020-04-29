`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/25 18:42:57
// Design Name: 
// Module Name: sort
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


module sort #(parameter N = 4)(
    output [N-1:0] s0,s1,s2,s3, //排序后的四个数据
    output reg done,    //排序结束标志
    input [N-1:0] x0,x1,x2,x3,  //待排序的数字
    input clk,rst   //时钟，复位，上升沿有�??
    );
    parameter SUB = 3'b001;
    wire [N-1:0] i0,i1,i2,i3;   //寄存器输入端
   // wire [N-1:0] s0,s1,s2,s3;   //寄存器输出端
    wire [N-1:0] a,b;           //ALU输入、输出端
    wire cf;
    reg m0,m1,m2,m5;
    reg [1:0] m3,m4;   //多�?�器选择信号
    reg en0,en1,en2,en3;   //寄存器使能信�??
    reg [2:0] current_state,next_state; //状�??
    parameter LOAD = 3'b000;
    parameter CX01 = 3'b001;
    parameter CX12 = 3'b010;
    parameter CX23 = 3'b011;
    parameter CX01S = 3'b100;
    parameter CX12S = 3'b101;
    parameter CX01SS = 3'b110;
    parameter HALT = 3'b111;
    //Data Path
    Register #(4) R0(.in(i0),.en(en0),.rst(rst),.clk(clk),.out(s0));
    Register #(4) R1(.in(i1),.en(en1),.rst(rst),.clk(clk),.out(s1));
    Register #(4) R2(.in(i2),.en(en2),.rst(rst),.clk(clk),.out(s2));
    Register #(4) R3(.in(i3),.en(en3),.rst(rst),.clk(clk),.out(s3));

    MUX2to1 #(4) M0(.m(m0),.d0(s0),.d1(s2),.out(a));
    MUX2to1 #(4) M1(.m(m1),.d0(s1),.d1(s3),.out(b));
    MUX2to1 #(4) M2(.m(m2),.d0(x0),.d1(s1),.out(i0));
    MUX3to1 #(4) M3(.m(m3),.d0(x1),.d1(s0),.d2(s2),.out(i1));
    MUX3to1 #(4) M4(.m(m4),.d0(x2),.d1(s1),.d2(s3),.out(i2));
    MUX2to1 #(4) M5(.m(m5),.d0(x3),.d1(s2),.out(i3));

    alu #(4) ALU(.a(a),.b(b),.m(SUB),.cf(cf),.of(),.zf(),.y());
    //control unit
    always @(posedge clk,posedge rst)
        if(rst)
            current_state <=LOAD;
        else
            current_state <= next_state;
    always @(*)
    begin
        case(current_state)
          LOAD:next_state <= CX01;
          CX01:next_state <= CX12;
          CX12:next_state <= CX23;
          CX23:next_state <= CX01S;
          CX01S:next_state <= CX12S;
          CX12S:next_state <= CX01SS;
          CX01SS:next_state <=HALT;
          HALT:next_state <= HALT;
        endcase
    end
    always @(*)
    begin
    {m0,m1,m2,m3,m4,m5,en0,en1,en2,en3,done} = 13'd0;
    case(current_state)
      LOAD:{en0,en1,en2,en3} = 4'b1111;
      CX01,CX01S,CX01SS:begin {m2,m3} = 3'b101;en0 = cf;en1 = cf;end
      CX12,CX12S:begin {m0,m1,m3,m4} = 6'b101001;en1 = ~cf;en2 = ~cf;end
      CX23:begin {m0,m1,m4,m5} = 5'b11101;en2 = cf;en3 = cf;end
      HALT:done = 1;
    endcase
    end
      
endmodule
