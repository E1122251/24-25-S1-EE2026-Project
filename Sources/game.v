`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 20:33:39
// Design Name: 
// Module Name: game
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


module game(
    
    input clock_100mhz,
    
    input [1:0] sw,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    input [12:0] pixel_index,
    
    input game_active,
    
    input mode,
    
    input difficulty,
    
    input [15:0] chassis_color,
    
    input [15:0] wheel_color,
    
    output [15:0] led_game,
    
    output [7:0] seg_game,
    output [3:0] an_game,
    
    output reg [15:0] oled_data_game,
    
    output return_to_menu
    
    );
    
    // declare wires begin
    
    wire is_speed_powerup_collision;
    wire is_shield_powerup_collision;
    
    wire toggle_game_clear_screen;
    
    // declare wires end
    
    
    // instantiate player begin
    
    wire [15:0] led_player;
    wire [15:0] oled_data_player;
    
    wire is_player_hitbox;
    wire is_player_hurtbox;
    
    player player_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .sw(sw),
        
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .pixel_index(pixel_index),
        
        .game_active(game_active),
        
        .chassis_color(chassis_color),
        .wheel_color(wheel_color),
        
        .is_speed_powerup_collision(is_speed_powerup_collision),
        .is_shield_powerup_collision(is_shield_powerup_collision),
        
        .toggle_game_clear_screen(toggle_game_clear_screen),
        
        .led_player(led_player),
        
        .oled_data_player(oled_data_player),
        
        .is_player_hitbox(is_player_hitbox),
        .is_player_hurtbox(is_player_hurtbox)
        
        );
    
    // instantiate player end
    
    
    // instantiate stage begin
    
    wire [15:0] led_stage;
    wire [15:0] oled_data_stage;
    
    wire is_obstacle_hitbox;
    
    wire is_speed_powerup_hitbox;
    wire is_shield_powerup_hitbox;
    
    wire [1:0] stage_mode;
    
    assign stage_mode = {difficulty, mode};
    
    stage stage_instance (
        
        .clock_100mhz(clock_100mhz),
        .game_active(game_active),
        .pixel_index(pixel_index),
        .mode(stage_mode),
        .oled_data(oled_data_stage),
        .selected_obstacle_hitbox(is_obstacle_hitbox),
        .is_speed_ramp_hitbox(is_speed_powerup_hitbox),
        .is_shield_powerup_hitbox(is_shield_powerup_hitbox)
        
        );
    
    // instantiate stage end
    
    
    // instantiate logic begin

    wire [7:0] seg_logic;
    wire [3:0] an_logic;
    wire [15:0] oled_data_collision;
    wire [15:0] oled_data_game_clear;
    wire is_collision;
    
    logic logic_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnC(btnC),
        .game_active(game_active),
        .mode(mode),
        .difficulty(difficulty),
        
        .is_player_hitbox(is_player_hitbox),
        .is_player_hurtbox(is_player_hurtbox),
        .is_obstacle_hitbox(is_obstacle_hitbox),
        .is_speed_powerup_hitbox(is_speed_powerup_hitbox),
        .is_shield_powerup_hitbox(is_shield_powerup_hitbox),
        .pixel_index(pixel_index),
                
        .seg(seg_logic),
        .an(an_logic),
        
        .is_collision(is_collision),
        .toggle_game_clear_screen(toggle_game_clear_screen),
        .is_speed_powerup_colliion(is_speed_powerup_collision),
        .is_shield_powerup_colliion(is_shield_powerup_collision),
        .oled_data_collision(oled_data_collision),
        .oled_data_game_clear(oled_data_game_clear),
        .return_to_menu(return_to_menu)
        
    );
    
    
    // instantiate logic end
    
    
    // control led_game begin
    
    assign led_game = led_player;
    
    // control led_game end
    
    
    // control seg_game and an_game begin
    
    assign seg_game = seg_logic;
    assign an_game = an_logic;
    
    // control seg_game and an_game end
    
    
    // always block to control oled_data_game begin
    
    always @(posedge clock_100mhz) begin
        
        if ( is_collision ) begin
            
            oled_data_game <= oled_data_collision;
            
        end else if ( toggle_game_clear_screen ) begin
            
            oled_data_game <= oled_data_game_clear;
            
        end else if ( oled_data_player != 0 ) begin
            
            oled_data_game <= oled_data_player;
            
        end else if ( oled_data_stage != 0 ) begin
        
            oled_data_game <= oled_data_stage;
            
        end else begin
            
            oled_data_game <= 0;
            
        end
        
    end
    
    // always block to control oled_data_game end
    
endmodule
