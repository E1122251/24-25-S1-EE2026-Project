`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 21:15:19
// Design Name: 
// Module Name: player_hitbox
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


module player_hitbox(
    
    input clock_100mhz,
    
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    
    input [6:0] player_x,
    input [5:0] player_y,
    
    input game_active,
    
    input player_is_invincible,
    
    output reg is_player_wheels,
    output reg is_player_chassis,
    
    output reg is_player_hitbox
    
    );
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            is_player_wheels = 0;
            is_player_chassis = 0;
            
            is_player_hitbox = 0;
            
        end else begin
            
            is_player_wheels = (
                
                ( pixel_x >= (player_x + 1) && pixel_x <= (player_x + 2) && pixel_y >= (player_y) && pixel_y <= (player_y + 1) ) ||
                ( pixel_x >= (player_x + 5) && pixel_x <= (player_x + 6) && pixel_y >= (player_y) && pixel_y <= (player_y + 1) ) ||
                
                ( pixel_x >= (player_x + 1) && pixel_x <= (player_x + 2) && pixel_y >= (player_y + 6) && pixel_y <= (player_y + 7) ) ||
                ( pixel_x >= (player_x + 5) && pixel_x <= (player_x + 6) && pixel_y >= (player_y + 6) && pixel_y <= (player_y + 7) )
                
                );
            
            is_player_chassis = (
                
                ( pixel_x >= (player_x) && pixel_x <= (player_x + 8) && pixel_y >= (player_y + 2) && pixel_y <= (player_y + 5) ) ||
                ( pixel_x == (player_x + 9) && pixel_y >= (player_y + 3) && pixel_y <= (player_y + 4) )
                
                );
            
            is_player_hitbox = ( ( !player_is_invincible ) && ( is_player_wheels || is_player_chassis ) );
        
        end
        
    end
    
endmodule
