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
    
    input [1:0] sw,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    input [12:0] pixel_index,
    
    input game_active,
    
    output [15:0] led_game,
    
    output [7:0] seg_game,
    output [3:0] an_game,
    
    output reg [15:0] oled_data_game,
    
    output return_to_menu
    
    );
    
    // localparam begin
    
    localparam RED = 16'd63488;
    
    // localparam end
    
    
    // instantiate player begin
    
    wire [15:0] led_player;
    wire [15:0] oled_data_player;
    
    wire is_player_hitbox;
    
    player player_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .sw(sw),
        
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .pixel_index(pixel_index),
        
        .game_active(game_active),
        
        .led_player(led_player),
        
        .oled_data_player(oled_data_player),
        
        .is_player_hitbox(is_player_hitbox)
        
        );
    
    // instantiate player end
    
    
    // instantiate stage begin
    
    wire [15:0] led_stage;
    wire [15:0] oled_data_stage;
    
    wire is_obstacle_hitbox;
    
    stage stage_instance (
        
        .clock_100mhz(clock_100mhz),
        .btnC(btnC),  
        .btnU(btnU),  
        .btnD(btnD), 
        .game_active(game_active),
        .pixel_index(pixel_index),
        .oled_data(oled_data_stage),
        .led(led_stage),
        .is_obstacle_hitbox(is_obstacle_hitbox)
        
        );
    
    // instantiate stage end
    
    
    // instantiate logic begin
    
    wire [7:0] seg_logic;
    wire [3:0] an_logic;
    
    wire [15:0] oled_data_collision;
    
    wire is_collision;
    
    logic logic_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnC(btnC),
        
        .game_active(game_active),
        
        .is_player_hitbox(is_player_hitbox),
        .is_obstacle_hitbox(is_obstacle_hitbox),
        
        .pixel_index(pixel_index),
                
        .seg(seg_logic),
        .an(an_logic),
        
        .oled_data_collision(oled_data_collision),
        
        .is_collision(is_collision),
        
        .return_to_menu(return_to_menu)
        
        );
    
    // instantiate logic end
    
    
    // control led_game begin
    
    assign led_game = led_player;
    
    // control led_game end
    
    
    // control seg_game and an_game begin
    
    assign seg_game = seg_logic;
    assign an_game = an_logic;
    
    // control seg_game and an_game end
    
    
    // always block to control oled_data_game begin
    
    always @(posedge clock_100mhz) begin
        
        if ( is_collision ) begin
            
            oled_data_game <= oled_data_collision;
            
        end else if ( oled_data_player != 0 ) begin
            
            oled_data_game <= oled_data_player;
            
        end else if ( oled_data_stage != 0 ) begin
        
            oled_data_game <= oled_data_stage;
            
        end else begin
            
            oled_data_game <= 0;
            
        end
        
    end
    
    // always block to control oled_data_game end
    
endmodule
