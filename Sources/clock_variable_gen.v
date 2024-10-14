`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2024 09:21:49
// Design Name: 
// Module Name: clock_variable_gen
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


module clock_variable_gen(
    
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
