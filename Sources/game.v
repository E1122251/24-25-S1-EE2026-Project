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
    
    output [7:0] seg_game,
    output [3:0] an_game,
    
    output reg [15:0] oled_data_game
    
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
        
        .btnC(btnC),
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
    
    logic logic_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .is_player_hitbox(is_player_hitbox),
        .is_obstacle_hitbox(is_obstacle_hitbox),
                
        .seg(seg_logic),
        .an(an_logic)
        
        );
    
    // instantiate logic end
    
    
    // control led_game begin
    
    assign led_game = led_player;
    
    // control led_game end
    
    
    // control seg_game and an_game begin
    
    assign seg_game = seg_logic;
    assign an_game = an_logic;
    
    // control seg_game and an_game end
    
    
    // always loop to control oled_data_game begin
    
    always @(posedge clock_100mhz) begin
        
        if ( is_player_hitbox && is_obstacle_hitbox ) begin
            
            oled_data_game <= RED;
            
        end else if ( is_player_hitbox ) begin
            
            oled_data_game <= oled_data_player;
            
        end else begin
        
            oled_data_game <= oled_data_stage;
            
        end
        
    end
    
    // always loop to control oled_data_game end
    
endmodule
