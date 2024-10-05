`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2024 09:23:01
// Design Name: 
// Module Name: flexi_clock
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


module flexi_clock(input clk,input [31:0] m,output reg slow_clk);

   reg [31:0] count = 0;
   always@(posedge clk) begin
     if (count == m-1) begin
        count <= 0;
        slow_clk <= ~slow_clk;
     end else begin
        count <= count+1;
     end
   end

endmodule
