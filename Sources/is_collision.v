`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 08:14:53 AM
// Design Name: 
// Module Name: is_collision
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


module is_collision(
    input clock_100mhz,
    input is_player_hitbox,
    input is_player_hurtbox,
    input is_obstacle_hitbox,
    input is_speed_powerup_hitbox,
    input is_shield_powerup_hitbox,
    input game_active,
    
    output reg is_collision=0,
    output reg is_speed_powerup_colliion=0,
    output reg is_shield_powerup_colliion=0
    );
    
    //collision detection start
    reg [3:0] collision_counter = 0; //collision_debounce
    always @ (posedge clock_100mhz) begin
        if (game_active == 0)begin
            is_collision <=0;
            collision_counter <=0;
            end
        else if ( is_player_hitbox && is_obstacle_hitbox ) begin
            if (collision_counter == 4'b1111) begin
                is_collision <= 1;
                end
            else begin
                collision_counter <= collision_counter +1;
            end
            end
        else begin
            collision_counter <= 0;         
            end
    end
    //collision detection end
    
    //speed powerup start
    reg [3:0] speed_powerup_counter = 0;
    always @ (posedge clock_100mhz) begin
        if (game_active == 0)begin
            is_speed_powerup_colliion <=0;
            speed_powerup_counter <=0;
            end
        else if ( is_player_hurtbox && is_speed_powerup_hitbox ) begin
            if (speed_powerup_counter == 4'b1111) begin
                is_speed_powerup_colliion <= 1;
                end
            else begin
                speed_powerup_counter <= speed_powerup_counter +1;
            end
            end
        else begin
            is_speed_powerup_colliion <=0;
            speed_powerup_counter <= 0;         
            end
    end
    //speed powerup end
    
    //shield powerup start
    reg [3:0] shield_powerup_counter = 0;
    always @ (posedge clock_100mhz) begin
        if (game_active == 0)begin
            is_shield_powerup_colliion <=0;
            shield_powerup_counter <=0;
            end
        else if ( is_player_hurtbox && is_shield_powerup_hitbox ) begin
            if (shield_powerup_counter == 4'b1111) begin
                is_shield_powerup_colliion <= 1;
                end
            else begin
                shield_powerup_counter <= shield_powerup_counter +1;
            end
            end
        else begin
            is_shield_powerup_colliion <=0;
            shield_powerup_counter <= 0;         
            end
    end 
    
    
    
endmodule
