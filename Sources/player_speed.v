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


module player_speed(
    
    input clock_100mhz,
    
    input [5:0] sw,
    
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    
    input game_active,
    
    output reg clock_player_move = 0
    
    );
        
    // instantiate clocks_player_gen begin
    
    wire clock_5hz_vsync; wire clock_10hz_vsync; wire clock_15hz_vsync; wire clock_20hz_vsync; wire clock_25hz_vsync; wire clock_30hz_vsync;
    
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
    
    
    // always loop to control clock_player_move begin
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            clock_player_move <= 1;
            
        end else if ( sw[5] ) begin
            
            clock_player_move <= clock_30hz_vsync;
            
        end else if ( sw[4] ) begin
            
            clock_player_move <= clock_25hz_vsync;
            
        end else if ( sw[3] ) begin
            
            clock_player_move <= clock_20hz_vsync;
            
        end else if ( sw[2] ) begin
            
            clock_player_move <= clock_15hz_vsync;
            
        end else if ( sw[1] ) begin 
            
            clock_player_move <= clock_10hz_vsync;
            
        end else if ( sw[0] ) begin
            
            clock_player_move <= clock_5hz_vsync;
            
        end else begin
            
            clock_player_move <= 0;
            
        end
        
    end
    
    // always loop to control clock_player_move end

    
endmodule
