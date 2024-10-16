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
    input is_player_hitbox,
    input is_obstacle_hitbox,
    
    output reg is_collision);
    always @ (*) begin
        if ( is_player_hitbox && is_obstacle_hitbox ) begin
            is_collision <= 1;
        end
        else begin
            is_collision <= 0;
        end
    end
endmodule
