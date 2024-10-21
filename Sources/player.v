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
    
    input [15:0] sw,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    input [12:0] pixel_index,
    
    input game_active,
    
    output [15:0] led_player,
    
    output reg [15:0] oled_data_player,
    
    output is_player_hitbox
    
    );
    
    // create pixel_x and pixel_y begin
    
    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    
    assign pixel_x = pixel_index % 96;
    assign pixel_y = pixel_index / 96;
    
    // create pixel_x and pixel_y end
    
    
    // instantiate player_pos begin
    
    wire [6:0] player_x;
    wire [5:0] player_y;
    
    player_pos player_pos_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        
        .game_active(game_active),
        
        .player_x(player_x),
        .player_y(player_y)
        
        );
    
    // instantiate player_pos end
    
    
    // instantiate player_hitbox begin
    
    wire is_player_wheels;
    wire is_player_chassis;
    
    player_hitbox player_hitbox_instance (
        
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        
        .player_x(player_x),
        .player_y(player_y),
        
        .is_player_wheels(is_player_wheels),
        .is_player_chassis(is_player_chassis),
        
        .is_player_hitbox(is_player_hitbox)
        
        );
    
    // instantiate player_hitbox end
    
    
    // instantiate player_disp begin
    
    assign led_player = sw;
    
    always @(posedge clock_100mhz) begin
        
        if ( is_player_wheels ) begin
            
            oled_data_player <= 16'd2016;
            
        end else if ( is_player_chassis ) begin
            
            oled_data_player <= 16'd2016;
            
        end else begin
            
            oled_data_player <= 0;
            
        end
        
    end
    
    // instantiate player_disp end
    
endmodule
