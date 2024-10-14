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
    
    input [15:0] sw,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    input [12:0] pixel_index,
    
    input game_active,
    
    output [15:0] led_game,
    
    output [15:0] oled_data_game
    
    );
    
    // instantiate player begin
    
    player player_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .sw(sw),
        
        .btnC(btnC),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .pixel_index(pixel_index),
        
        .game_active(game_active),
        
        .led_player(led_game),
        
        .oled_data_player(oled_data_game)
        
        );
    
    // instantiate player end
    
endmodule
