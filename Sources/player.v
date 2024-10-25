`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 20:36:13
// Design Name: 
// Module Name: player
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


module player(
    
    input clock_100mhz,
    
    input [1:0] sw,
    
    input btnU, btnL, btnR, btnD,
    
    input [12:0] pixel_index,
    
    input game_active,
    
    output [15:0] led_player,
    
    output [15:0] oled_data_player,
    
    output is_player_hitbox
    
    );
    
    // create pixel_x and pixel_y begin
    
    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    
    assign pixel_x = pixel_index % 96;
    assign pixel_y = pixel_index / 96;
    
    // create pixel_x and pixel_y end
    
    
    // always block to control powerups state begin
    
    reg player_is_invincible = 0;
    reg player_is_speedy = 0;
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            player_is_invincible <= 0;
            player_is_speedy <= 0;
            
        end else begin
            
            if ( sw[1] ) begin
                
                player_is_invincible <= 1;
                
            end else begin
                
                player_is_invincible <= 0;
                
            end
            
            if ( sw[0] ) begin
                
                player_is_speedy <= 1;
                
            end else begin
                
                player_is_speedy <= 0;
                
            end
            
        end
        
    end
    
    // always block to control powerups state end
    
    
    // instantiate player_pos begin
    
    wire [6:0] player_x;
    wire [5:0] player_y;
    
    wire [3:0] player_move_hor_state; 
    wire [3:0] player_move_vert_state;
    
    player_pos player_pos_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        
        .game_active(game_active),
        
        .player_is_speedy(player_is_speedy),
        
        .player_x(player_x),
        .player_y(player_y),
        
        .player_move_hor_state(player_move_hor_state), 
        .player_move_vert_state(player_move_vert_state)
        
        );
    
    // instantiate player_pos end
    
    
    // instantiate player_hitbox begin
    
    wire is_player_wheels;
    wire is_player_chassis;
    
    player_hitbox player_hitbox_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        
        .player_x(player_x),
        .player_y(player_y),
        
        .game_active(game_active),
        
        .player_is_invincible(player_is_invincible),
        
        .is_player_wheels(is_player_wheels),
        .is_player_chassis(is_player_chassis),
        
        .is_player_hitbox(is_player_hitbox)
        
        );
    
    // instantiate player_hitbox end
    
    
    // instantiate player_led begin
    
    player_led player_led_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .player_move_hor_state(player_move_hor_state),
        .player_move_vert_state(player_move_vert_state),
        
        .player_is_invincible(player_is_invincible),
        .player_is_speedy(player_is_speedy),
        
        .led_player(led_player)
        
        );
    
    // instantiate player_led end
    
    
    // instantiate player_display begin
    
    player_display player_display_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .game_active(game_active),
        
        .is_player_wheels(is_player_wheels),
        .is_player_chassis(is_player_chassis),
        
        .player_is_invincible(player_is_invincible),
        .player_is_speedy(player_is_speedy),
        
        .oled_data_player(oled_data_player)
        
        );
    
    // instantiate player_display end
    
endmodule
