`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 07:49:37 AM
// Design Name: 
// Module Name: score_display
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


module logic(
    input clock_100mhz,
    
    input btnC,
    input game_active,
    
    input is_player_hitbox,
    input is_obstacle_hitbox,
    input [12:0] pixel_index,
            
    output [7:0] seg,
    output [3:0] an,
    
    output is_collision,
    output [15:0] oled_data_collision,
    output return_to_menu
    );
    
    
    // instantiate is_collision begin
    is_collision is_collision_instance (
        .clock_100mhz(clock_100mhz), 
        
        .is_player_hitbox(is_player_hitbox),
        .is_obstacle_hitbox(is_obstacle_hitbox),
        .game_active(game_active),
        
        .is_collision(is_collision)
        );
    // instantiate is_collision end
    
    
    // instantiate screen_after_collision begin
    screen_after_collision screen_after_collision_instance(
        .clock_100mhz(clock_100mhz),
        .pixel_index(pixel_index),
        .game_active(game_active),
        .is_collision(is_collision),
        .btnC(btnC),
        
        .oled_data_collision(oled_data_collision),
        .return_to_menu(return_to_menu)
        );
    // instantiate screen_after_collision end
    
    
    
    // instantiate score_logic begin
    score_logic score_logic_instance(
        .clock_100mhz(clock_100mhz),
        
        .is_collision(is_collision),
        .game_active(game_active),
            
        .seg(seg),
        .an(an)
        );
    // instantiate score_logic end
    
        
endmodule
