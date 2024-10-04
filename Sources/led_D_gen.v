`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 18:24:33
// Design Name: 
// Module Name: led_D_gen
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


module led_D_gen(
    
    input clock_100mhz,
    
    output [15:0] led_D
    
    );
    
    wire clock_9hz;
    
    clock_variable_gen clock_9hz_gen ( .clock_100mhz(clock_100mhz), .m(32'd5555555), .clock_output(clock_9hz) );
    
    assign led_D[0] = clock_9hz;
    assign led_D[2] = clock_9hz;
    assign led_D[4] = clock_9hz;
    assign led_D[7] = clock_9hz;
    assign led_D[8] = clock_9hz;
    assign led_D[15] = clock_9hz;
    
    assign led_D[1] = 1'b0;
    assign led_D[3] = 1'b0;
    assign led_D[5] = 1'b0;
    assign led_D[6] = 1'b0;
    assign led_D[9] = 1'b0;
    assign led_D[10] = 1'b0;
    assign led_D[11] = 1'b0;
    assign led_D[12] = 1'b0;
    assign led_D[13] = 1'b0;
    assign led_D[14] = 1'b0;
    
endmodule
