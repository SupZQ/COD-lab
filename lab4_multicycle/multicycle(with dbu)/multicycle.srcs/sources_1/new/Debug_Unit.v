`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 14:40:07
// Design Name: 
// Module Name: Debug_Unit
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


module Debug_Unit(
    input clk,rst,  //时钟，复位
    input succ,step,    //连续执行，单步执行
    input m_rf,inc,dec, //M/R选择，addr加减
    input [2:0] sel,    //cpuc查看选择
    input [6*32+16-1:0] status,    //PC,IR,MD,A,B,ALUOut,signal
    input [31:0] m_data,rf_data,
    output run,  //cpu控制，数码管控制
    output  [7:0] an,
    output reg [7:0] m_rf_addr,
    output reg [15:0] led,
    output  [7:0] seg
    );

    //wire step_clr,inc_clr,dec_clr;
    wire step_p,inc_p,dec_p;
    reg [31:0] data;
    //信号处理,按键需处理，扳动无需处理
    //jitter_clr step_BTNC(clk,step,step_clr);
    //jitter_clr inc_BTNU(clk,inc,inc_clr);
    //jitter_clr dec_BUND(clk,dec,dec_clr);
    signal_edge step_edge(clk,step,step_p); //上板时记得修改
    signal_edge inc_edge(clk,inc,inc_p);
    signal_edge dec_edge(clk,dec,dec_p);

    assign run = succ|step_p; //run

    //m_rf_addr
    wire inc_dec;
    assign inc_dec = inc_p|dec_p;
    always @(posedge inc_dec,posedge rst)
    begin
        if(rst)
            m_rf_addr = 0;
        else
        begin
            case({inc_p,dec_p})
            2'b00,2'b11:m_rf_addr = m_rf_addr;
            2'b01:m_rf_addr = m_rf_addr-1;
            2'b10:m_rf_addr = m_rf_addr+1;
            endcase
        end
    end


    always @(*)
    begin
        led = {{4{1'b0}},status[11:0]};
        case(sel)
        3'b000: 
        begin
            led = {{8{1'b0}},m_rf_addr};
            if(m_rf)
                data = m_data;
            else
                data = rf_data;
        end
        3'b001:data = status[207:176];   //PC
        3'b010:data = status[175:144];   //IR
        3'b011:data = status[143:112];   //MD
        3'b100:data = status[111:80 ];   //A
        3'b101:data = status[79 :48 ];   //B
        3'b110:data = status[47 :16 ];   //ALUOut
        3'b111:data = status[15 :0  ];   //signal
        endcase
    end

    seven_segment segment(clk,data,8'hFF,an,seg);

endmodule
