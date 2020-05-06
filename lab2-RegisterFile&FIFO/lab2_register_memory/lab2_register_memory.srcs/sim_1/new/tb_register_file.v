`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/05 16:00:50
// Design Name: 
// Module Name: tb_register_file
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


module tb_register_file;   

// register_file Parameters
parameter PERIOD = 10;     
parameter WIDTH = 4;       

// register_file Inputs
reg   clk                                  = 0 ;
reg   [4:0]  ra0                           = 0 ;
reg   [4:0]  ra1                           = 0 ;
reg   [4:0]  wa                            = 0 ;
reg   we                                   = 0 ;
reg   [WIDTH-1:0]  wd                      = 0 ;

// register_file Outputs
wire  [WIDTH-1:0]  rd0                     ;
wire  [WIDTH-1:0]  rd1                     ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    forever #PERIOD we=~we;
end



register_file #(4) u_register_file  (
    .clk                     ( clk              ),
    .ra0                     ( ra0  [4:0]       ),
    .ra1                     ( ra1  [4:0]       ),
    .wa                      ( wa   [4:0]       ),
    .we                      ( we               ),
    .wd                      ( wd   [WIDTH-1:0] ),

    .rd0                     ( rd0  [WIDTH-1:0] ),
    .rd1                     ( rd1  [WIDTH-1:0] )
);

initial
begin

    repeat(3) begin
    ra0 = $random%32;
    ra1 = $random%32;
    wa = ra0;
    wd = $random%16;
    #(PERIOD*2);
    end

    repeat(3)
    begin
    ra0 = $random%32;
    ra1 = $random%32;
    wa = ra1;
    wd = $random%16;
    #(PERIOD*2);
    end
    $finish;
    /*
    
    
    ra0 = 0;
    ra1 = 1;
    wa = 1;
    wd = 2;

    #(PERIOD*2)
    ra0 = 15;
    ra1 = 16;
    wa = 15;
    wd = 3;

    #(PERIOD*2)
    ra0 = 15;
    ra1 = 16;
    wa = 16;
    wd = 4;

    #(PERIOD*2)
    ra0 = 30;
    ra1 = 31;
    wa = 30;
    wd = 5;

    #(PERIOD*2)
    ra0 = 30;
    ra1 = 31;
    wa = 31;
    wd = 6;
    
    #(PERIOD*2)
    $finish;
    */
end

endmodule
