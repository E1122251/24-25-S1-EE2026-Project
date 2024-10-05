`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 20:57:11
// Design Name: 
// Module Name: blink_led_B
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


module blink_led_B(
    input clk,
    input [31:0] freq_div,
    input enable,
    output reg led
    );
    
    reg [31:0] count = 0;
    
    always @(posedge clk) begin
      if (enable) begin
        if (count == freq_div-1) begin
              count <= 0;
              led <= ~led;      
        end else begin
              count <= count + 1;
        end
      end 
    end
    
endmodule
