`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 19:39:48
// Design Name: 
// Module Name: dbu_top
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


module dbu_top(
    input clk,rst,  //时钟，复位
    input succ,step,    //连续执行，单步执行
    input m_rf,inc,dec, //M/R选择，地址加减
    input [2:0] sel,    //输出控制
    output [15:0] led,  //led
    output [7:0] an,    //seven segment enable
    output [7:0] seg    //seven segment output
    );

    wire run;
    wire [235:0] status;
    wire [31:0] m_data,rf_data;
    wire [7:0] m_rf_addr;

    Debug_Unit dbu(
        .clk            (clk        ),
        .rst            (rst        ),
        .succ           (succ       ),
        .step           (step       ),
        .sel            (sel        ),
        .m_rf           (m_rf       ),
        .inc            (inc        ),
        .dec            (dec        ),
        .status         (status     ),
        .m_data         (m_data     ),
        .rf_data        (rf_data    ),
        .run            (run        ),
        .m_rf_addr      (m_rf_addr  ),
        .led            (led        ),
        .an             (an         ),
        .seg            (seg        )
    );

    cpu cpu(
        .clk            (clk        ),
        .rst            (rst        ),
        .run            (run        ),
        .m_rf_addr      (m_rf_addr  ),
        .status         (status     ),
        .m_data         (m_data     ),
        .rf_data        (rf_data    )
    );

endmodule
