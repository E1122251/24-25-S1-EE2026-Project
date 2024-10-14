`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 07:26:23 AM
// Design Name: 
// Module Name: clock_1hz
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


module clock_1hz(input clock_100mhz, output reg clock_1hz);
    reg [31:0] count = 0;
    always @ (posedge clock_100mhz)
    begin
        count <= (count == 99999999) ? 0 : count+1;
        clock_1hz <= (count == 0) ? ~clock_1hz:clock_1hz;
    end
endmodule
