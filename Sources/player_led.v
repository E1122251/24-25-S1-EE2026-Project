`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2024 16:27:23
// Design Name: 
// Module Name: player_led
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


module player_led(
    
    input clock_100mhz,
    
    input [3:0] player_move_hor_state,
    input [3:0] player_move_vert_state,
    
    input player_is_invincible,
    input player_is_speedy,
    
    output reg [15:0] led_player
    
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
    
    // localparam end
    
    
    // hor_speed begin
    
    reg [3:0] hor_speed = 6;
    
    always @(posedge clock_100mhz) begin
            
            if ( player_move_hor_state == LEFT_6 ) begin
                
                hor_speed <= 0;
                
            end else if ( player_move_hor_state == LEFT_5 ) begin
                
                hor_speed <= 1;
                
            end else if ( player_move_hor_state == LEFT_4 ) begin
                
                hor_speed <= 2;
                
            end else if ( player_move_hor_state == LEFT_3 ) begin
                
                hor_speed <= 3;
                
            end else if ( player_move_hor_state == LEFT_2 ) begin
                
                hor_speed <= 4;
                
            end else if ( player_move_hor_state == LEFT_1 ) begin
                
                hor_speed <= 5;
                
            end else if ( player_move_hor_state == STOP ) begin
                
                hor_speed <= 6;
                
            end else if ( player_move_hor_state == RIGHT_1 ) begin
                
                hor_speed <= 7;
                
            end else if ( player_move_hor_state == RIGHT_2 ) begin
                
                hor_speed <=  8;
                
            end else if ( player_move_hor_state == RIGHT_3 ) begin
                
                hor_speed <=  9;
                
            end else if ( player_move_hor_state == RIGHT_4 ) begin
                
                hor_speed <=  10;
                
            end else if ( player_move_hor_state == RIGHT_5 ) begin
                
                hor_speed <=  11;
                
            end else if ( player_move_hor_state == RIGHT_6 ) begin
                
                hor_speed <=  12;
                
            end
            
        end
    
    // vert_speed begin
    
    reg [2:0] vert_speed = 0;
    
    always @(posedge clock_100mhz) begin
        
        if ( player_move_vert_state == STOP ) begin
            
            vert_speed <= 0;
            
        end else if ( ( player_move_vert_state == UP_1 ) || ( player_move_vert_state == DOWN_1 ) ) begin
            
            vert_speed <= 1;
            
        end else if ( ( player_move_vert_state == UP_2 ) || ( player_move_vert_state == DOWN_2 ) ) begin
            
            vert_speed <= 2;
            
        end else if ( ( player_move_vert_state == UP_3 ) || ( player_move_vert_state == DOWN_3 ) ) begin
            
            vert_speed <= 3;
            
        end else if ( ( player_move_vert_state == UP_4 ) || ( player_move_vert_state == DOWN_4 ) ) begin
            
            vert_speed <= 4;
            
        end else if ( ( player_move_vert_state == UP_5 ) || ( player_move_vert_state == DOWN_5 ) ) begin
            
            vert_speed <= 5;
            
        end else if ( ( player_move_vert_state == UP_6 ) || ( player_move_vert_state == DOWN_6 ) ) begin
            
            vert_speed <= 6;
            
        end
        
    end
    
    // vert_speed eng
    
    
    // speed begin
    
    reg [4:0] speed = 6;
    
    always @(posedge clock_100mhz) begin
        
        speed <= hor_speed + vert_speed;
        
    end
    
    // speed end
    
    
    // always block to control led_player[15:7] begin
    
    wire clock_1khz;
    
    clock_variable_gen clock_1khz_gen ( .clock_100mhz(clock_100mhz), .m(32'd49_999), .clock_output(clock_1khz) );
    
    always @(posedge clock_100mhz) begin
        
        if ( speed == 0 ) begin
            
            led_player[15:7] <= 9'b0_0000_0000;
            
        end else if ( speed == 1 ) begin
            
            led_player[15] <= clock_1khz;
            led_player[14:7] <= 8'b0000_0000;
            
        end else if ( speed == 2 ) begin
            
            led_player[15] <= 1'b1;
            led_player[14:7] <= 8'b0000_0000;
            
        end else if ( speed == 3 ) begin
            
            led_player[15] <= 1'b1;
            led_player[14] <= clock_1khz;
            led_player[13:7] <= 7'b000_0000;
            
        end else if ( speed == 4 ) begin
            
            led_player[15:14] <= 2'b11;
            led_player[13:7] <= 7'b000_0000;
            
        end else if ( speed == 5 ) begin
            
            led_player[15:14] <= 2'b11;
            led_player[13] <= clock_1khz;
            led_player[12:7] <= 6'b00_0000;
            
        end else if ( speed == 6 ) begin
            
            led_player[15:13] <= 3'b111;
            led_player[12:7] <= 6'b00_0000;
            
        end else if ( speed == 7 ) begin
            
            led_player[15:13] <= 3'b111;
            led_player[12] <= clock_1khz;
            led_player[11:7] <= 5'b0_0000;
            
        end else if ( speed == 8 ) begin
            
            led_player[15:12] <= 4'b1111;
            led_player[11:7] <= 5'b0_0000;
            
        end else if ( speed == 9 ) begin
            
            led_player[15:12] <= 4'b1111;
            led_player[11] <= clock_1khz;
            led_player[10:7] <= 4'b0000;
            
        end else if ( speed == 10 ) begin
            
            led_player[15:11] <= 5'b1_1111;
            led_player[10:7] <= 4'b0000;
            
        end else if ( speed == 11 ) begin
            
            led_player[15:11] <= 5'b1_1111;
            led_player[10] <= clock_1khz;
            led_player[9:7] <= 3'b000;
            
        end else if ( speed == 12 ) begin
            
            led_player[15:10] <= 6'b11_1111;
            led_player[9:7] <= 3'b000;
            
        end else if ( speed == 13 ) begin
            
            led_player[15:10] <= 6'b11_1111;
            led_player[9] <= clock_1khz;
            led_player[8:7] <= 2'b00;
            
        end else if ( speed == 14 ) begin
            
            led_player[15:9] <= 7'b111_1111;
            led_player[8:7] <= 2'b00;
            
        end else if ( speed == 15 ) begin
            
            led_player[15:9] <= 7'b111_1111;
            led_player[8] <= clock_1khz;
            led_player[7] <= 1'b0;
            
        end else if ( speed == 16 ) begin
            
            led_player[15:8] <= 8'b1111_1111;
            led_player[7] <= 1'b0;
            
        end else if ( speed == 17 ) begin
            
            led_player[15:8] <= 8'b1111_1111;
            led_player[7] <= clock_1khz;
            
        end else if ( speed == 18 ) begin
            
            led_player[15:7] <= 9'b1_1111_1111;
            
        end
        
    end
    
    // always block to control led_player[15:7] end
    
    
    // always block to control led_player[6:2] begin
    
    always @(posedge clock_100mhz) begin
        
        led_player[6:2] <= 5'b0_0000;
        
    end
    
    // always block to control led_player[6:2] end
    
    
    // always block to control led_player[1:0] begin
    
    always @(posedge clock_100mhz) begin
        
        if ( player_is_invincible ) begin
            
            led_player[1] <= 1;
            
        end else begin
            
            led_player[1] <= 0;
            
        end
        
        if ( player_is_speedy ) begin
            
            led_player[0] <= 1;
            
        end else begin
            
            led_player[0] <= 0;
            
        end
        
    end
    
    // always block to control led_player[1:0] end
    
endmodule
