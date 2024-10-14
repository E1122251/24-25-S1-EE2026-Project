`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 07:49:37 AM
// Design Name: 
// Module Name: score_display
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


module score_display(
    input clock_100mhz,
    input iscollision,
            
    output reg [6:0] seg,
    output reg [3:0] an
    );
    //counting score when no collision
    wire clock_1hz;
    reg [15:0] score = 0;
    clock_1hz a1 (.clock_100mhz(clock_100mhz), .clock_1hz(clock_1hz));
    always @(posedge clock_1hz) begin
        if (iscollision == 0)begin 
            score <= score+1;
            end
        else begin
            score <= score;
            end
        end
    
    
    //displaying score
    reg [1:0] nth_an_display; // 2-bit counter for selecting the display
    reg [3:0] decimal;
    reg [15:0] slow_down_clock; // Divider to slow down the clock
    //slow down nth an to display properly
    always @(posedge clock_100mhz) begin
        slow_down_clock <= slow_down_clock + 1;
        if (slow_down_clock == 0) begin
            nth_an_display <= nth_an_display + 1; // Increment slower
            end
    end
    // display each decimal
    always @(*) begin
        case (decimal)
            4'd0: seg = 7'b1000000; // "0"
            4'd1: seg = 7'b1111001; // "1"
            4'd2: seg = 7'b0100100; // "2"
            4'd3: seg = 7'b0110000; // "3"
            4'd4: seg = 7'b0011001; // "4"
            4'd5: seg = 7'b0010010; // "5"
            4'd6: seg = 7'b0000010; // "6"
            4'd7: seg = 7'b1111000; // "7"
            4'd8: seg = 7'b0000000; // "8"
            4'd9: seg = 7'b0010000; // "9"
            default : seg = 7'b1111111;
        endcase
    end
    //display each digit
    always @(posedge clock_100mhz) begin
        case (nth_an_display)
            2'b00: begin
            an = 4'b1110;
            decimal = score%10;
            end
            2'b01: begin
            an = 4'b1101;
            decimal = (score/10)%10;
            end
            2'b10: begin
            an = 4'b1011;
            decimal = (score/100)%10;
            end
            2'b11: begin
            an = 4'b0111;
            decimal = (score/1000)%10;
            end      
        endcase
    end
    
endmodule
