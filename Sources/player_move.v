`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 22:03:27
// Design Name: 
// Module Name: player_move
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


module player_move(
    
    input clock_100mhz,
    
    input btnU, btnL, btnR, btnD,
    
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    
    input game_active,
    
    input player_at_left_edge,
    input player_at_right_edge,
    
    input player_at_top_edge,
    input player_at_bot_edge,
    
    input player_is_speedy,
    
    output reg [6:0] player_x = 7'd0,
    output reg [5:0] player_y = 6'd28,
    
    output [3:0] player_move_hor_state, 
    output [3:0] player_move_vert_state
    
    );
    
    // localparam begin
    
    localparam LEFT_6  = 4'd0;
    localparam UP_6    = 4'd0;
    
    localparam LEFT_5  = 4'd1;
    localparam UP_5    = 4'd1;
    
    localparam LEFT_4  = 4'd2;
    localparam UP_4    = 4'd2;
    
    localparam LEFT_3  = 4'd3;
    localparam UP_3    = 4'd3;
    
    localparam LEFT_2  = 4'd4;
    localparam UP_2    = 4'd4;
    
    localparam LEFT_1  = 4'd5;
    localparam UP_1    = 4'd5;
    
    localparam STOP    = 4'd6;
    
    localparam RIGHT_1 = 4'd7;
    localparam DOWN_1  = 4'd7;
    
    localparam RIGHT_2 = 4'd8;
    localparam DOWN_2  = 4'd8;
    
    localparam RIGHT_3 = 4'd9;
    localparam DOWN_3  = 4'd9;
    
    localparam RIGHT_4 = 4'd10;
    localparam DOWN_4  = 4'd10;
    
    localparam RIGHT_5 = 4'd11;
    localparam DOWN_5  = 4'd11;
    
    localparam RIGHT_6 = 4'd12;
    localparam DOWN_6  = 4'd12;
    
    localparam NULL  = 2'b00;
    
    localparam LEFT  = 2'b01;
    localparam UP    = 2'b01;
    
    localparam RIGHT = 2'b10;
    localparam DOWN  = 2'b10;
    
    localparam DELAY = 32'd20_000_000;
    
    // localparam end
    
    // instantiate player_move_input begin
    
    wire [1:0] input_hor; wire [1:0] input_vert;
    
    player_move_input player_move_input_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .game_active(game_active),
        
        .input_hor(input_hor),
        
        .input_vert(input_vert)
        
        );
    
    // instantiate player_move_input end
    
    
    // instantiate player_vector begin
    
    wire clock_player_move_hor; wire clock_player_move_vert;
    
    player_vector player_vector_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .input_hor(input_hor),
        .input_vert(input_vert),
        
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        
        .game_active(game_active),
        
        .player_at_left_edge(player_at_left_edge),
        .player_at_right_edge(player_at_right_edge),
        
        .player_at_top_edge(player_at_top_edge),
        .player_at_bot_edge(player_at_bot_edge),
        
        .player_is_speedy(player_is_speedy),
        
        .player_move_hor_state(player_move_hor_state),
        .player_move_vert_state(player_move_vert_state),
        
        .clock_player_move_hor(clock_player_move_hor),
        .clock_player_move_vert(clock_player_move_vert)
        
        );
    
    // instantiate player_vector end
    
    
    // always block to control player_x begin
    
    always @(posedge clock_player_move_hor) begin
        
        if ( !game_active ) begin
            
            player_x <= 0;
            
        end else begin
            
            if ( ( ( player_move_hor_state >= LEFT_6 ) && ( player_move_hor_state <= LEFT_1 ) ) && !player_at_left_edge ) begin
                
                player_x <= player_x - 1;
                
            end else if ( ( ( player_move_hor_state >= RIGHT_1 ) && ( player_move_hor_state <= RIGHT_6 ) ) && !player_at_right_edge ) begin
                
                player_x <= player_x + 1;
                
            end 
            
        end
        
    end
    
    // always block to control player_x end
    
    
    // always block to control player_y begin
    
    always @(posedge clock_player_move_vert) begin
        
        if ( !game_active ) begin
                
                player_y <= 28;
                
        end else begin
                
            if ( ( ( player_move_vert_state >= UP_6 ) && ( player_move_vert_state <= UP_1 ) ) && !player_at_top_edge ) begin
                
                player_y <= player_y - 1;
                
            end else if ( ( ( player_move_vert_state >= DOWN_1 ) && ( player_move_vert_state <= DOWN_6 ) ) && !player_at_bot_edge ) begin
                
                player_y <= player_y + 1;
                
            end
            
        end
        
    end
    
    // always block to control player_y end
    
endmodule
