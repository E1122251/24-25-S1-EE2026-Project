`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2024 21:26:24
// Design Name: 
// Module Name: player_display
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


module player_display(
    
    input clock_100mhz,
    
    input game_active,
    
    input is_player_wheels,
    input is_player_chassis,
    
    input player_is_invincible,
    input player_is_speedy,
    
    output reg [15:0] oled_data_player
    
    );
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            oled_data_player <= 0;
            
        end else if ( is_player_wheels ) begin
            
            if ( !player_is_speedy ) begin
                
                oled_data_player <= 16'd2016;
                
            end else begin
                
                oled_data_player <= 16'd65248;
                
            end
            
        end else if ( is_player_chassis ) begin
            
            if ( !player_is_invincible ) begin
                
                oled_data_player <= 16'd2016;
                
            end else begin
                
                oled_data_player <= 16'd65248;
                
            end
            
        end else begin
            
            oled_data_player <= 0;
            
        end
        
    end
    
endmodule