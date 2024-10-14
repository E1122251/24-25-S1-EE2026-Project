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
    
    input [5:0] sw,
    
    input btnU, btnL, btnR, btnD,
    
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    
    input game_active,
    
    input player_at_left_edge,
    input player_at_right_edge,
    
    input player_at_top_edge,
    input player_at_bot_edge,
    
    output reg [6:0] player_x = 7'd0,
    output reg [5:0] player_y = 6'd28
    
    );
    
    // localparam begin
    
    localparam NULL = 2'b00;
    
    localparam LEFT = 2'b01;
    localparam RIGHT = 2'b10;
    
    localparam UP = 2'b01;
    localparam DOWN = 2'b10;
    
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
    
    
    // instantiate player_speed begin
    
    wire clock_player_move;
    
    player_speed player_speed_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .sw(sw),
        
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        
        .game_active(game_active),
        
        .clock_player_move(clock_player_move)
        
        );
    
    // instantiate player_speed end
    
    
    // always block to control player_x begin
    
    always @(posedge clock_player_move) begin
        
        if ( !game_active ) begin
            
            player_x <= 0;
            
        end else begin
        
            if ( ( input_hor == LEFT ) && !player_at_left_edge ) begin
                
                player_x <= player_x - 1;
                
            end else if ( ( input_hor == RIGHT ) && !player_at_right_edge ) begin
                
                player_x <= player_x + 1;
                
            end 
        
        end
        
    end
    
    // always block to control player_x end
    
    
    // always block to control player_y begin
    
    always @(posedge clock_player_move) begin
        
        if ( !game_active ) begin
                
                player_y <= 28;
                
            end else begin
                
                if ( ( input_vert == UP ) && !player_at_top_edge ) begin
                    
                    player_y <= player_y - 1;
                    
                end else if ( ( input_vert == DOWN ) && !player_at_bot_edge ) begin
                    
                    player_y <= player_y + 1;
                    
                end
                
            end
        
    end
    
    // always block to control player_y end
    
endmodule
