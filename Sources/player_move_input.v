`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 23:24:29
// Design Name: 
// Module Name: player_move_input
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


module player_move_input(
    
    input clock_100mhz,
    
    input btnU, btnL, btnR, btnD,
    
    input game_active,
    
    output reg [1:0] input_hor = 2'b00,
    
    output reg [1:0] input_vert = 2'b00
    
    );
    
    // localparam begin
    
    localparam NULL = 2'b00;
    
    localparam LEFT = 2'b01;
    localparam RIGHT = 2'b10;
    
    localparam UP = 2'b01;
    localparam DOWN = 2'b10;
    
    // localparam end
    
    
    // always block to control input_hor begin
    
    reg [1:0] storage_hor = 2'b00; reg [1:0] storage_vert = 3'b00;
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            input_hor <= NULL;
            
        end else begin
            
            if ( storage_hor != {btnL, btnR} ) begin
                
                storage_hor <= {btnL, btnR};
                
                if ( !btnL && !btnR ) begin
                    
                    input_hor <= NULL;
                    
                end else if ( btnL && !btnR ) begin
                    
                    input_hor <= LEFT;
                    
                end else if ( !btnL && btnR ) begin
                    
                    input_hor <= RIGHT;
                    
                end else if ( btnL && btnR ) begin
                    
                    input_hor <= ~input_hor;
                    
                end
                
            end
            
        end
        
    end
    
    // always block to control input_hor end
    
    
    // always block to control input_vert begin
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active ) begin
            
            input_vert <= NULL;
            
        end else begin
            
            if ( storage_vert != {btnU, btnD} ) begin
                
                storage_vert <= {btnU, btnD};
                
                if ( !btnU && !btnD ) begin
                    
                    input_vert <= NULL;
                    
                end else if ( btnU && !btnD ) begin
                    
                    input_vert <= UP;
                    
                end else if ( !btnU && btnD ) begin
                    
                    input_vert <= DOWN;
                    
                end else if ( btnU && btnD ) begin
                    
                    input_vert <= ~input_vert;
                    
                end
                
            end
            
        end
        
    end
    
    // always block to control input_vert begin
    
endmodule
