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
    input obstacle_hitbox_b,
    input obstacle_hitbox_l,
    input obstacle_hitbox_r,
    input obstacle_hitbox_t,

    input car_hitbox_b,
    input car_hitbox_l,
    input car_hitbox_r,
    input car_hitbox_t,
    
    output [3:0] collision_tblr
    );
    wire collision_top;
    wire collision_bottom;
    wire collision_left;
    wire collision_right;  

    assign collision_top =  ( ( car_hitbox_t   == obstacle_hitbox_b ) && ( car_hitbox_r >= obstacle_hitbox_l) && ( car_hitbox_l <= obstacle_hitbox_r ) );
    assign collision_bottom = ( ( car_hitbox_b   == obstacle_hitbox_t ) && ( car_hitbox_r >= obstacle_hitbox_l) && ( car_hitbox_l <= obstacle_hitbox_r ));
    assign collision_left =  ( ( car_hitbox_l  == obstacle_hitbox_r ) && ( car_hitbox_b  >= obstacle_hitbox_t) && ( car_hitbox_t  <= obstacle_hitbox_b ));
    assign collision_right = ( ( car_hitbox_r == obstacle_hitbox_l ) && ( car_hitbox_b  >= obstacle_hitbox_t) && ( car_hitbox_t  <= obstacle_hitbox_b ));
    
    assign collision_tblr = {collision_top, collision_bottom, collision_left, collision_right};
    
endmodule
