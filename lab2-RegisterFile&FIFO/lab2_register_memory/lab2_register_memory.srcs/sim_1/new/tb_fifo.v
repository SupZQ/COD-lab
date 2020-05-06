`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 13:37:09
// Design Name: 
// Module Name: tb_fifo
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


module tb_fifo;        

// fifo Parameters     
parameter PERIOD  = 10;


// fifo Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 1 ;
reg   [7:0]  din                           = 0 ;
reg   en_in                                = 0 ;
reg   en_out                               = 0 ;

// fifo Outputs
wire  [7:0]  dout                          ;
wire  [4:0]  count                         ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end


initial
begin
    forever 
    #(3*PERIOD)  din = $random%256;
end

initial
begin
    forever 
    begin
    #(PERIOD)   rst=0;
    #(PERIOD*80)   rst=1;
    end
end

fifo  u_fifo (
    .clk                     ( clk           ),
    .rst                     ( rst           ),
    .din                     ( din     [7:0] ),
    .en_in                   ( en_in         ),
    .en_out                  ( en_out        ),

    .dout                    ( dout    [7:0] ),
    .count                   ( count   [4:0] )
);

initial
begin
    #(PERIOD)   {en_in,en_out}=2'b00;
    #(PERIOD)   {en_in,en_out}=2'b01;   //POP
    #(PERIOD)   {en_in,en_out}=2'b10;   //PUSH
    #(PERIOD)   {en_in,en_out}=2'b00;   //remain
    #(PERIOD)   {en_in,en_out}=2'b01;   //POP
    #(PERIOD)   {en_in,en_out}=2'b00;   //remain
    repeat(2)
    begin
    #(PERIOD)   {en_in,en_out}=2'b10;   //PUSH
    #(PERIOD*2) {en_in,en_out}=2'b00;   //remain
    end

    repeat(14)
    begin
    #(PERIOD)   {en_in,en_out}=2'b10;   //PUSH
    #(PERIOD)   {en_in,en_out}=2'b00;   //remain
    end

    #(PERIOD)   {en_in,en_out}=2'b11;   //PUSH,full
    #(PERIOD)   {en_in,en_out}=2'b00;   //remain
    

    repeat(16)
    begin
    #(PERIOD)   {en_in,en_out}=2'b01;   //POP
    #(PERIOD)   {en_in,en_out}=2'b00;   //remain
    end
    #(PERIOD*10)   $finish;
end


endmodule
