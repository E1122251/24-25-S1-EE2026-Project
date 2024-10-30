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
    
    input [15:0] chassis_color,
    input [15:0] wheel_color,
    
    input is_speed_powerup_collision,
    input is_shield_powerup_collision,
    
    input toggle_game_clear_screen,
    
    output [15:0] led_player,
    
    output [15:0] oled_data_player,
    
    output is_player_hitbox,
    output is_player_hurtbox
    
    );
    
    // localparam begin
    
    localparam POWERUP_TIME = 32'd500_000_000;
    
    // localparam end
    
    // create pixel_x and pixel_y begin
    
    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    
    assign pixel_x = pixel_index % 96;
    assign pixel_y = pixel_index / 96;
    
    // create pixel_x and pixel_y end
    
    
    // always block to control player_is_invincible begin
    
    reg player_is_invincible_pickup = 0;
    reg [31:0] invincible_pickup_duration = 0;
     
    reg player_is_invincible = 0;
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            player_is_invincible_pickup <= 0;
            invincible_pickup_duration <= 0;
            
        end else begin
            
            if ( is_shield_powerup_collision ) begin
                
                player_is_invincible_pickup <= 1;
                invincible_pickup_duration <= POWERUP_TIME;
                
            end else begin
                
                if ( invincible_pickup_duration != 0 ) begin
                    
                    invincible_pickup_duration <= invincible_pickup_duration - 1;
                    
                end else begin
                    
                    player_is_invincible_pickup <= 0;
                    
                end
                
            end
            
        end
    
    end
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            player_is_invincible <= 0;
            
        end else begin
            
            if ( player_is_invincible_pickup || sw[1] ) begin
                
                player_is_invincible <= 1;
                
            end else begin
                
                player_is_invincible <= 0;
                
            end
            
        end
        
    end
    
    // always block to control player_is_invincible end
    
    
    // always block to control player_is_speedy begin
    
    reg player_is_speedy_pickup = 0;
    reg [31:0] speedy_pickup_duration = 0;
     
    reg player_is_speedy = 0;
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            player_is_speedy_pickup <= 0;
            speedy_pickup_duration <= 0;
            
        end else begin
            
            if ( is_speed_powerup_collision ) begin
                
                player_is_speedy_pickup <= 1;
                speedy_pickup_duration <= POWERUP_TIME;
                
            end else begin
                
                if ( speedy_pickup_duration != 0 ) begin
                    
                    speedy_pickup_duration <= speedy_pickup_duration - 1;
                    
                end else begin
                    
                    player_is_speedy_pickup <= 0;
                    
                end
                
            end
            
        end
    
    end
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            player_is_speedy <= 0;
            
        end else begin
            
            if ( player_is_speedy_pickup || sw[0] || toggle_game_clear_screen ) begin
                
                player_is_speedy <= 1;
                
            end else begin
                
                player_is_speedy <= 0;
                
            end
            
        end
        
    end

    // always block to control player_is_speedy end
    
    
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
        
        .is_player_hitbox(is_player_hitbox),
        .is_player_hurtbox(is_player_hurtbox)
        
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
        
        .chassis_color(chassis_color),
        
        .wheel_color(wheel_color),
        
        .oled_data_player(oled_data_player)
        
        );
    
    // instantiate player_display end
    
endmodule
