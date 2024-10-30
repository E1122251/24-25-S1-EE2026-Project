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
    input is_speed_powerup_hitbox,
    input is_shield_powerup_hitbox,
    input [12:0] pixel_index,
            
    output [7:0] seg,
    output [3:0] an,
    
    output is_collision,
    output toggle_game_clear_screen,
    output is_speed_powerup_colliion,
    output is_shield_powerup_colliion,
    output [15:0] oled_data_collision,
    output [15:0] oled_data_game_clear,
    output return_to_menu
    );
    
    
    // instantiate is_collision begin
    is_collision is_collision_instance (
        .clock_100mhz(clock_100mhz), 
        
        .is_player_hitbox(is_player_hitbox),
        .is_obstacle_hitbox(is_obstacle_hitbox),
        .is_speed_powerup_hitbox(is_speed_powerup_hitbox),
        .is_shield_powerup_hitbox(is_shield_powerup_hitbox),
        .game_active(game_active),
        
        .is_collision(is_collision),
        .is_speed_powerup_colliion(is_speed_powerup_colliion),
        .is_shield_powerup_colliion(is_shield_powerup_colliion)
        );
    // instantiate is_collision end
    wire return_death;
    assign return_to_menu = return_death;

    // instantiate screen_after_collision begin
    screen_after_collision screen_after_collision_instance(
        .clock_100mhz(clock_100mhz),
        .pixel_index(pixel_index),
        .game_active(game_active),
        .is_collision(is_collision),
        .btnC(btnC),
        
        .oled_data_collision(oled_data_collision),
        .return_to_logic(return_death)
        );
    // instantiate screen_after_collision end
    
    

    // instantiate score_logic begin
    wire [13:0] score;
    score_logic score_logic_instance(
        .clock_100mhz(clock_100mhz),
        
        .is_collision(is_collision),
        .toggle_game_clear_screen(toggle_game_clear_screen),
        .game_active(game_active),
            
        .seg(seg),
        .an(an),
        .score(score)
        );
    // instantiate score_logic end
    wire return_clear;
    assign return_to_menu = return_clear;
    // instantiate screen_game_clear begin
    screen_game_clear screen_game_clear_instance(
        .clock_100mhz(clock_100mhz),
        .pixel_index(pixel_index),
        .game_active(game_active),
        
        .score(score),
        .btnC(btnC),
        
        .toggle_game_clear_screen(toggle_game_clear_screen),
        .oled_data_game_clear(oled_data_game_clear),
        .return_to_logic(return_clear)
        );
    // instantiate screen_game_clear end
    always @ (*) begin
        if (return_win ==1 || return_death ==1) begin
            return_to_menu_in_logic <= 1;
            end
        end
    
    
    
        
endmodule
