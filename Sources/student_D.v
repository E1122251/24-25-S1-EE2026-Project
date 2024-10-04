`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 17:31:17
// Design Name: 
// Module Name: student_D
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


module student_D(
    
    input clock_100mhz,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    input [12:0] pixel_index,
    
    input password_D,
    
    output [15:0] led_D,
    
    output [15:0] oled_data_D
    
    );
    
    // convert led_index to led_x and led_y begin
    
    wire [6:0] led_x;
    wire [5:0] led_y;
    
    assign led_x = pixel_index % 96;
    assign led_y = pixel_index / 96;
        
    // convert led_index to led_x and led_y end
        
    // instantiate led_D_gen begin
    
    led_D_gen led_D_gen_instance ( .clock_100mhz(clock_100mhz), .led_D(led_D) );
    
    // instantiate led_D_gen end
    
    // instantiate oled_data_D_gen begin
    
    oled_data_D_gen oled_data_D_gen_instance (
    
    .clock_100mhz(clock_100mhz),
    
    .btnC(btnC),
    .btnU(btnU),
    .btnL(btnL),
    .btnR(btnR),
    .btnD(btnD),
    
    .led_x(led_x),
    .led_y(led_y),
    
    .password_D(password_D),
    
    .oled_data_D(oled_data_D)
    
    );
    
    // instantiate oled_data_D_gen end
       
endmodule