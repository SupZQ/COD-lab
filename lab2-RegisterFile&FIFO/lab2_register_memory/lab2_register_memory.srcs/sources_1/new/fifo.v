`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 11:44:07
// Design Name: 
// Module Name: fifo
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


module fifo(
    input clk, rst,		//时钟（上升沿有效）、异步复位（高电平有效）
    input [7:0] din,		//入队列数据
    input en_in, 		//入队列使能，高电平有效
    input en_out,		//出队列使能，高电平有效
    output [7:0] dout, 	//出队列数据
    output [4:0] count	//队列数据计数
    );

    wire re,we;  //边沿信号
    wire ena;   //总使能
    wire wea;   //写使能
    wire empty,full;    //队列标志
    wire [3:0] pt_r,pt_w;   //队列指针
    wire [3:0] addr;    //RAM地址

    //结构化描述数据通路
    signal_edge re_gen(.clk(clk),.button(en_out) ,.button_edge(re));
    signal_edge we_gen(.clk(clk),.button(en_in),.button_edge(we));

    pt_read  pt_r_gen(.clk(clk),.rst(rst),.re(re),.we(we),.empty(empty),.pt_r(pt_r));
    pt_write pt_w_gen(.clk(clk),.rst(rst),.we(we),.full (full ),.pt_w(pt_w));
    MUX2to1  mux(.m(we),.d0(pt_r),.d1(pt_w),.out(addr));

    flag_FSM flag(.clk(clk),.rst(rst),.we(we),.re(re),.full(full),.empty(empty),.count(count));

    assign wea = we&(~full);
    assign ena = we|re;
    //dist_mem RAM(.clk(clk),.a(addr),.we(RAM_write),.d(din),.spo(dout));
    blk_mem RAM(.clka(clk),.addra(addr),.dina(din),.ena(ena),.wea(wea),.douta(dout));



endmodule
