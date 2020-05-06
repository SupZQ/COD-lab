`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 10:40:11
// Design Name: 
// Module Name: flag_FSM
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


module flag_FSM
    #(parameter MAX_LEN = 16)
    (
    input clk,rst,
    input we,re,
    output reg full,empty,
    output reg [4:0] count
    );

    parameter EMPTY = 2'b00;
    parameter NORMAL = 2'b01;
    parameter FULL = 2'b10;
    parameter OTHER = 2'b11;

    reg [1:0] current_state,next_state;

    always @(posedge clk,posedge rst)
    begin
        if(rst)
            current_state <= EMPTY;
        else
            current_state <= next_state;
    end
    //设置优先级，write高于read
    always @(*)
    begin
    case(current_state)
    EMPTY:
        begin
        case({we,re})
        2'b00,2'b01:begin next_state = EMPTY ; count = 0; end
        2'b10,2'b11:begin next_state = NORMAL; count = 1; end
        endcase
        end
    NORMAL:
        begin
        case({we,re})
        2'b00:begin next_state = NORMAL; count = count;end
        2'b01:
            begin
            count = count-1;
            if(count == 0)
                next_state = EMPTY;
            else
                next_state = NORMAL;
            
            end
        2'b10,2'b11:
            begin
            count = count+1;
            if(count == MAX_LEN)
                next_state = FULL;
            else
                next_state = NORMAL;
            end
        endcase
        end
    FULL:
        begin
        case({we,re})
        2'b00,2'b10,2'b11:begin next_state = FULL; count = count; end
        2'b01:begin next_state =NORMAL;count = count-1; end
        endcase
        end
    OTHER:begin next_state = EMPTY; count = 0; end
    endcase
    end

    always @(*)
    begin
    case(current_state)
        EMPTY,OTHER:{empty,full} = 2'b10;
        NORMAL:{empty,full} = 2'b00;
        FULL:{empty,full} = 2'b01;
    endcase
    end

endmodule
