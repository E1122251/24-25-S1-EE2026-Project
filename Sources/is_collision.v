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
    input is_obstacle_hitbox,
    input game_active,
    
    output reg is_collision=0);
    
    reg [3:0] counter = 0; //collision_debounce
    always @ (posedge clock_100mhz) begin
        if (game_active == 0)begin
            is_collision <=0;
            counter <=0;
            end
        else if ( is_player_hitbox && is_obstacle_hitbox ) begin
            if (counter == 4'b1111) begin
                is_collision <= 1;
                end
            else begin
                counter <= counter +1;
            end
            end
        else begin
            counter <= 0;         
            end
    end
endmodule
