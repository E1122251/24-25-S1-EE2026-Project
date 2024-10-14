`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 19:57:06
// Design Name: 
// Module Name: debounce
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


module debounce(
    
    input clock_100mhz,
    
    input signal,
    
    output reg signal_debounced = 0
    
    );
    
    localparam delay_time = 32'd5_000_000;
    
    reg [31:0] delay;
    
    always @(posedge clock_100mhz) begin
        
        if ( delay != 0 ) begin
            
            delay <= delay - 1;
            
        end else if ( signal == 1 ) begin
            
            if ( signal_debounced == 1 ) begin
                
                signal_debounced <= 1;
                
            end else if ( signal_debounced == 0 ) begin
                
                signal_debounced <= 1;
                
                delay <= delay_time;
                
            end
            
        end else if ( signal == 0 ) begin
            
            if ( signal_debounced == 1 ) begin
                
                signal_debounced <= 0;
                
                delay <= delay_time;
                
            end else if ( signal_debounced == 0 ) begin
                
                signal_debounced <= 0;
                
            end
            
        end
        
    end
    
endmodule
