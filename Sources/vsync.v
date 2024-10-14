`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 20:22:39
// Design Name: 
// Module Name: vsync
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


module vsync(
    
    input clock_100mhz,
    
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    
    input clock,
    
    output reg clock_vsync = 0
    
    );
    
    wire last_pixel;
    
    assign last_pixel = ( pixel_x == 95 ) && ( pixel_y == 63);
    
    always @(posedge clock_100mhz) begin
            
            if ( clock ) begin
                
                if ( last_pixel ) begin
                    
                    clock_vsync <= 1;
                    
                end else if ( !last_pixel ) begin
                    
                    clock_vsync <= clock_vsync;
                    
                end
                
            end else if ( !clock ) begin
                
                clock_vsync <= 0;
                
            end
            
        end
    
endmodule
