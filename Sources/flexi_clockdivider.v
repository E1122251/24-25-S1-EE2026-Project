`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2024 03:29:11 PM
// Design Name: 
// Module Name: flexi_clockdivider
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


module flexi_clockdivider(
input clock_100mhz,
input [31:0] m,

output reg clock_output = 0

);

reg [31:0] count = 0;

always @(posedge clock_100mhz) begin

count <= ( count == m ) ? 0 : count + 1;
clock_output <= ( count == 0 ) ? ~clock_output : clock_output;

end

endmodule
