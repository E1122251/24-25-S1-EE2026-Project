`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 22:16:24
// Design Name: 
// Module Name: player_speed
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


module player_vector (
    
    input clock_100mhz,
    
    input [1:0] input_hor,
    input [1:0] input_vert,
    
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    
    input game_active,
    
    input player_at_left_edge,
    input player_at_right_edge,
    
    input player_at_top_edge,
    input player_at_bot_edge,
    
    input player_is_speedy,
    
    output reg [3:0] player_move_hor_state = 4'd6,
    output reg [3:0] player_move_vert_state = 4'd6,
    
    output reg clock_player_move_hor = 0,
    output reg clock_player_move_vert = 0
    
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
    
    localparam DELAY = 32'd10_000_000;
    
    // localparam end
    
    
    // instantiate clocks_player_gen begin
    
    wire clock_5hz_vsync;  wire clock_10hz_vsync; wire clock_15hz_vsync;
    wire clock_20hz_vsync; wire clock_25hz_vsync; wire clock_30hz_vsync;
    
    clocks_player_gen clocks_player_gen_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        
        .clock_5hz_vsync(clock_5hz_vsync),
        .clock_10hz_vsync(clock_10hz_vsync),
        .clock_15hz_vsync(clock_15hz_vsync),
        .clock_20hz_vsync(clock_20hz_vsync),
        .clock_25hz_vsync(clock_25hz_vsync),
        .clock_30hz_vsync(clock_30hz_vsync)
        
        );
        
    // instantiate clocks_player_gen end
    
    
    // always loop to control player_move_hor_state begin
    
    reg [31:0] delay_hor = 0;
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            player_move_hor_state <= STOP;
            delay_hor <= 0;
            
        end else begin
            
            if ( delay_hor != 0 ) begin
                
                delay_hor <= delay_hor - 1;
                
            end else if ( input_hor == LEFT ) begin
                
                if ( player_at_left_edge ) begin
                    
                    player_move_hor_state <= STOP;
                    
                end else if ( player_is_speedy ) begin
                    
                    player_move_hor_state <= LEFT_6;
                    
                end else if ( player_move_hor_state == LEFT_6) begin
                    
                    player_move_hor_state <= player_move_hor_state;
                    
                end else if ( ( player_move_hor_state >= LEFT_5 ) && ( player_move_hor_state <= RIGHT_1 ) ) begin
                    
                    player_move_hor_state <= player_move_hor_state - 1;
                    delay_hor <= DELAY;
                    
                end else if ( ( player_move_hor_state >= RIGHT_2 ) && ( player_move_hor_state <= RIGHT_6 ) ) begin
                    
                    player_move_hor_state <= player_move_hor_state - 2;
                    delay_hor <= DELAY;
                    
                end
                
            end else if ( input_hor == RIGHT ) begin
                
                if ( player_at_right_edge ) begin
                    
                    player_move_hor_state <= STOP;
                    
                end else if ( player_is_speedy ) begin
                    
                    player_move_hor_state <= RIGHT_6;
                    
                end else if ( ( player_move_hor_state >= LEFT_6 ) && ( player_move_hor_state <= LEFT_2 ) ) begin
                    
                    player_move_hor_state <= player_move_hor_state + 2;
                    delay_hor <= DELAY;
                    
                end else if ( ( player_move_hor_state >= LEFT_1 ) && ( player_move_hor_state <= RIGHT_5 ) ) begin
                    
                    player_move_hor_state <= player_move_hor_state + 1;
                    delay_hor <= DELAY;
                    
                end else if ( player_move_hor_state == RIGHT_6 ) begin
                    
                    player_move_hor_state <= player_move_hor_state;
                    
                end
                
            end else if ( input_hor == NULL ) begin
                
                if ( player_is_speedy) begin
                    
                    player_move_hor_state <= STOP;
                    
                end else if ( ( player_move_hor_state >= LEFT_6 ) && ( player_move_hor_state <= LEFT_1 ) ) begin
                    
                    player_move_hor_state <= player_move_hor_state + 1;
                    delay_hor <= DELAY;
                    
                end else if ( player_move_hor_state == STOP ) begin
                    
                    player_move_hor_state <= player_move_hor_state;
                    
                end else if ( ( player_move_hor_state >= RIGHT_1 ) && ( player_move_hor_state <= RIGHT_6 ) ) begin
                    
                    player_move_hor_state <= player_move_hor_state - 1;
                    delay_hor <= DELAY;
                    
                end
                
            end
            
        end
        
    end
    
    // always loop to control player_move_hor_state end
    
    
    // always loop to control player_move_vert_state begin
    
    reg [31:0] delay_vert = 0;
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            player_move_vert_state <= STOP;
            delay_vert <= 0;
            
        end else begin
            
            if ( delay_vert != 0 ) begin
                
                delay_vert <= delay_vert - 1;
                
            end else if ( input_vert == UP ) begin
                
                if ( player_at_top_edge ) begin
                    
                    player_move_vert_state <= STOP;
                    
                end else if ( player_is_speedy ) begin
                    
                    player_move_vert_state <= UP_6;
                    
                end else if ( player_move_vert_state == UP_6) begin
                    
                    player_move_vert_state <= player_move_vert_state;
                    
                end else if ( ( player_move_vert_state >= UP_5 ) && ( player_move_vert_state <= DOWN_1 ) ) begin
                    
                    player_move_vert_state <= player_move_vert_state - 1;
                    delay_vert <= DELAY;
                    
                end else if ( ( player_move_vert_state >= DOWN_2 ) && ( player_move_vert_state <= DOWN_6 ) ) begin
                    
                    player_move_vert_state <= player_move_vert_state - 2;
                    delay_vert <= DELAY;
                    
                end
                
            end else if ( input_vert == DOWN ) begin
                
                if ( player_at_bot_edge ) begin
                    
                    player_move_vert_state <= STOP;
                    
                end else if ( player_is_speedy ) begin
                    
                    player_move_vert_state <= DOWN_6;
                    
                end else if ( ( player_move_vert_state >= UP_6 ) && ( player_move_vert_state <= UP_2 ) ) begin
                    
                    player_move_vert_state <= player_move_vert_state + 2;
                    delay_vert <= DELAY;
                    
                end else if ( ( player_move_vert_state >= UP_1 ) && ( player_move_vert_state <= DOWN_5 ) ) begin
                    
                    player_move_vert_state <= player_move_vert_state + 1;
                    delay_vert <= DELAY;
                    
                end else if ( player_move_vert_state == DOWN_6 ) begin
                    
                    player_move_vert_state <= player_move_vert_state;
                    
                end
                
            end else if ( input_vert == NULL ) begin
                
                if ( player_is_speedy ) begin
                    
                    player_move_vert_state <= STOP;
                    
                end else if ( ( player_move_vert_state >= UP_6 ) && ( player_move_vert_state <= UP_1 ) ) begin
                    
                    player_move_vert_state <= player_move_vert_state + 1;
                    delay_vert <= DELAY;
                    
                end else if ( player_move_vert_state == STOP ) begin
                    
                    player_move_vert_state <= player_move_vert_state;
                    
                end else if ( ( player_move_vert_state >= DOWN_1 ) && ( player_move_vert_state <= DOWN_6 ) ) begin
                    
                    player_move_vert_state <= player_move_vert_state - 1;
                    delay_vert <= DELAY;
                    
                end
                
            end
            
        end
        
    end
        
    // always loop to control player_move_vert_state end
    
    
    // always loop to control clock_player_move_hor begin
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            clock_player_move_hor <= 1;
            
        end else begin
            
            if ( player_move_hor_state == STOP ) begin
                
                clock_player_move_hor <= ~clock_player_move_hor;
                
            end else if ( ( player_move_hor_state == LEFT_1 ) ||  ( player_move_hor_state == RIGHT_1 ) ) begin
                
                clock_player_move_hor <= clock_5hz_vsync;
                
            end else if ( ( player_move_hor_state == LEFT_2 ) ||  ( player_move_hor_state == RIGHT_2 ) ) begin
                
                clock_player_move_hor <= clock_10hz_vsync;
                
            end else if ( ( player_move_hor_state == LEFT_3 ) ||  ( player_move_hor_state == RIGHT_3 ) ) begin
                
                clock_player_move_hor <= clock_15hz_vsync;
                
            end else if ( ( player_move_hor_state == LEFT_4 ) ||  ( player_move_hor_state == RIGHT_4 ) ) begin
                
                clock_player_move_hor <= clock_20hz_vsync;
                
            end else if ( ( player_move_hor_state == LEFT_5 ) ||  ( player_move_hor_state == RIGHT_5 ) ) begin
                
                clock_player_move_hor <= clock_25hz_vsync;
                
            end else if ( ( player_move_hor_state == LEFT_6 ) ||  ( player_move_hor_state == RIGHT_6 ) ) begin
                
                clock_player_move_hor <= clock_30hz_vsync;

            end
        
        end
    
    end
    
    // always loop to control clock_player_move_hor end
    
    
    // always loop to control clock_player_move_vert begin
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            clock_player_move_vert <= ~clock_player_move_vert;
            
        end else begin
            
            if ( player_move_vert_state == STOP ) begin
                
                clock_player_move_vert <= 0;
                
            end else if ( ( player_move_vert_state == UP_1 ) ||  ( player_move_vert_state == DOWN_1 ) ) begin
                
                clock_player_move_vert <= clock_5hz_vsync;
                
            end else if ( ( player_move_vert_state == UP_2 ) ||  ( player_move_vert_state == DOWN_2 ) ) begin
                
                clock_player_move_vert <= clock_10hz_vsync;
                
            end else if ( ( player_move_vert_state == UP_3 ) ||  ( player_move_vert_state == DOWN_3 ) ) begin
                
                clock_player_move_vert <= clock_15hz_vsync;
                
            end else if ( ( player_move_vert_state == UP_4 ) ||  ( player_move_vert_state == DOWN_4 ) ) begin
                
                clock_player_move_vert <= clock_20hz_vsync;
                
            end else if ( ( player_move_vert_state == UP_5 ) ||  ( player_move_vert_state == DOWN_5 ) ) begin
                
                clock_player_move_vert <= clock_25hz_vsync;
                
            end else if ( ( player_move_vert_state == UP_6 ) ||  ( player_move_vert_state == DOWN_6 ) ) begin
                
                clock_player_move_vert <= clock_30hz_vsync;

            end
        
        end
    
    end    
    
    // always loop to control clock_player_move_vert end
    
endmodule
