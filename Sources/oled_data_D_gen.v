`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 21:05:01
// Design Name: 
// Module Name: oled_data_D_gen
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


module oled_data_D_gen(
    
    input clock_100mhz,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    input [6:0] led_x,
    input [5:0] led_y,
    
    input password_D,
    
    output reg [15:0] oled_data_D
    
    );
    
    // sq_big begin
    
    wire [6:0] sq_big_left;
    wire [5:0] sq_big_top;
    
    wire [6:0] sq_big_right;
    wire [5:0] sq_big_bot;
    
    assign sq_big_left = 7'd35;
    assign sq_big_top = 6'd19;
    
    assign sq_big_right = sq_big_left + 7'd24;
    assign sq_big_bot = sq_big_top + 6'd24;
    
    wire is_sq_big;
    
    assign is_sq_big = ( ( led_x >= sq_big_left ) && ( led_x <= sq_big_right ) &&  ( led_y >= sq_big_top ) && ( led_y <= sq_big_bot ) );
        
    // sq_big end
        
    // sq_g begin
    
    wire [6:0] sq_g_left;
    wire [5:0] sq_g_top;
    wire [6:0] sq_g_right;
    wire [5:0] sq_g_bot;
    
    wire sq_g_moving;
        
    // instantiate oled_data_D_sq_g_pos begin
    
    oled_data_D_sq_g_pos oled_data_D_sq_g_pos_instance (
    
    .clock_100mhz(clock_100mhz),
    
    .btnC(btnC),
    .btnU(btnU),
    .btnL(btnL),
    .btnR(btnR),
    .btnD(btnD),
        
    .password_D(password_D),
    
    .sq_big_left(sq_big_left),
    .sq_big_top(sq_big_top),
    .sq_big_right(sq_big_right),
    .sq_big_bot(sq_big_bot),
    
    .sq_g_left(sq_g_left),
    .sq_g_top(sq_g_top),
    
    .sq_g_right(sq_g_right),
    .sq_g_bot(sq_g_bot),
    
    .sq_g_moving(sq_g_moving)
    
    );
    
    // instantiate oled_data_D_sq_g_pos end
    
    wire is_sq_g;
    
    assign is_sq_g = ( ( led_x >= sq_g_left ) && ( led_x <= sq_g_right ) &&  ( led_y >= sq_g_top ) && ( led_y <= sq_g_bot ) );
    
    // sq_g end
    
    // colours begin
    
    wire [15:0] sq_g_colour;
    reg [15:0] sq_big_colour;
    wire [15:0] black_colour;
    
    assign sq_g_colour = 16'd2016;
    assign black_colour = 16'd0;
    
    always @(posedge clock_100mhz) begin
        
        if ( sq_g_moving ) begin
            
            sq_big_colour <= 16'd65504;
            
        end else begin
            
            sq_big_colour <= 16'd63488;
            
        end
        
    end
    
    // colours end
    
    // always block to assign oled_data_D begin
    
    always @(posedge clock_100mhz) begin
        
        if ( is_sq_g ) begin
                
            oled_data_D <= sq_g_colour;
                
        end else if ( is_sq_big ) begin
                
            oled_data_D <= sq_big_colour;
                
        end else begin
                
            oled_data_D <= black_colour;
                
        end
            
    end
    
    // always block to assign oled_data_D end
    
endmodule
