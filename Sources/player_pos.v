`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 20:43:01
// Design Name: 
// Module Name: player_pos
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


module player_pos(
    
    input clock_100mhz,
    
    input btnU, btnL, btnR, btnD,
    
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    
    input game_active,
    
    output [6:0] player_x,
    output [5:0] player_y
    
    );
    
    // variables for tracking player position begin
    
    wire [6:0] player_left;
    wire [6:0] player_right;
    
    wire [5:0] player_top;
    wire [5:0] player_bot;
    
    assign player_left = player_x;
    assign player_right = player_x + 9;
    
    assign player_top = player_y;
    assign player_bot = player_y + 7;
    
    // variables for tracking player postion end
    
    
    // variables for tracking player contact with edges of screen begin
    
    wire player_at_left_edge;
    wire player_at_right_edge;
    
    wire player_at_top_edge;
    wire player_at_bot_edge;
    
    assign player_at_left_edge  = ( player_left  == 0  );
    assign player_at_right_edge = ( player_right == 95 );
    
    assign player_at_top_edge   = ( player_top   == 0  );
    assign player_at_bot_edge   = ( player_bot   == 63 );
    
    // variables for tracking player contact with edges of screen end
    
    
    // instantiate player_move begin
    
    player_move player_move_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        
        .game_active(game_active),
        
        .player_at_left_edge(player_at_left_edge),
        .player_at_right_edge(player_at_right_edge),
        
        .player_at_top_edge(player_at_top_edge),
        .player_at_bot_edge(player_at_bot_edge),
        
        .player_x(player_x),
        .player_y(player_y)
        
        );
    
    // instantiate player_move end
    
endmodule
