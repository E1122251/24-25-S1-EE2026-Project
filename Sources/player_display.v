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
    
    input [15:0] chassis_color,
    
    input [15:0] wheel_color,
    
    output reg [15:0] oled_data_player
    
    );
    
    localparam GOLD = 16'd65248;
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            oled_data_player <= 0;
            
        end else if ( is_player_wheels ) begin
            
            if ( !player_is_speedy ) begin
                
                oled_data_player <= wheel_color;
                
            end else begin
                
                oled_data_player <= GOLD;
                
            end
            
        end else if ( is_player_chassis ) begin
            
            if ( !player_is_invincible ) begin
                
                oled_data_player <= chassis_color;
                
            end else begin
                
                oled_data_player <= GOLD;
                
            end
            
        end else begin
            
            oled_data_player <= 0;
            
        end
        
    end
    
endmodule
