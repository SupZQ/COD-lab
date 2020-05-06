`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/05 22:06:29
// Design Name: 
// Module Name: tb_blk_mem
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


module tb_blk_mem;


// blk_mem Parameters
parameter PERIOD = 10; 

// blk_mem Inputs
reg   clka                                 = 0 ;
reg   [3:0]  addra                         = 0 ;
reg   [7:0]  dina                          = 0 ;
reg   ena                                  = 0 ;
reg   wea                                  = 0 ;
// blk_mem Outputs
wire  [7:0] douta                              ;

initial
begin
    forever #(PERIOD/2)  clka=~clka;
end

initial
begin
    forever #(PERIOD) wea=~wea;
end

initial
begin
    forever #(PERIOD*2) ena=~ena;
end


blk_mem  u_blk_mem (
    .clka                    ( clka              ),
    .addra                   ( addra    [3:0]    ),
    .dina                    ( dina  [7:0]       ),
    .wea                     ( wea               ),
    .ena                     ( ena               ),
    .douta                   ( douta  [7:0]      )
);

initial
begin
    repeat(3) begin
    addra = $random%16;
    dina  = $random%256;
    #(PERIOD*4);
    end

    repeat(3)
    begin
    addra = $random%16;
    dina  = $random%256;
    #(PERIOD*4);
    end
    $finish;
end



endmodule
