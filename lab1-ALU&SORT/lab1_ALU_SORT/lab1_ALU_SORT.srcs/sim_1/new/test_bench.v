`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/22 23:32:41
// Design Name: 
// Module Name: test_bench
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

//~ `New testbench
`timescale  1ns / 1ps  

module tb_alu;

// alu Parameters      
parameter WIDTH  = 32;


// alu Inputs
reg   [WIDTH-1:0]  a                       = 0 ;
reg   [WIDTH-1:0]  b                       = 0 ;
reg   [2:0]  m                             = 0 ;

// alu Outputs
wire  [WIDTH-1:0]  y                       ;
wire  zf                                   ;
wire  cf                                   ;
wire  of                                   ;


alu   u_alu (
    .a                       ( a   [WIDTH-1:0] ),
    .b                       ( b   [WIDTH-1:0] ),
    .m                       ( m   [2:0]       ),

    .y                       ( y   [WIDTH-1:0] ),
    .zf                      ( zf              ),
    .cf                      ( cf              ),
    .of                      ( of              )
);

initial
begin
        m=3'b000;a=32'h7FFF_FFFF;b=32'h7FFF_FFFF;
    #5  m=3'b000;a=32'h7FFF_FFFF;b=32'h0000_0001;
    #5 m=3'b000;a=32'hFFFF_FFFF;b=32'hFFFF_FFFF;
    #5 m=3'b001;a=32'h8000_0001;b=32'h8000_0001;
    #5 m=3'b001;a=32'h8000_0001;b=32'h7FFF_FFFF;
    #5 m=3'b001;a=32'h0000_0001;b=32'h0000_0002;
    #5 m=3'b010;a=32'hAAAA_AAAA;b=32'hAAAA_AAAA;
    #5 m=3'b010;a=32'hAAAA_AAAA;b=32'h5555_5555;
    #5 m=3'b011;a=32'hAAAA_AAAA;b=32'hAAAA_AAAA;
    #5 m=3'b011;a=32'hAAAA_AAAA;b=32'h5555_5555;
    #5 m=3'b100;a=32'hAAAA_AAAA;b=32'hAAAA_AAAA;
    #5 m=3'b100;a=32'hAAAA_AAAA;b=32'h5555_5555;
    $finish;
end

endmodule