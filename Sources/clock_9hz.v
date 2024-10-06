`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 04:39:32 AM
// Design Name: 
// Module Name: clock_9hz
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


module clock_9hz(input clock_100mhz, output reg clock_9hz);
    reg [31:0] count = 0;
    always @ (posedge clock_100mhz)
    begin
        count <= (count == 11111111) ? 0 : count+1;
        clock_9hz <= (count == 0) ? ~clock_9hz:clock_9hz;
    end
endmodule
