`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 20:53:17
// Design Name: 
// Module Name: oled_data_init_gen
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


module oled_data_init_gen(
    
    input clock_100mhz,
    
    input [12:0] pixel_index,
    
    output reg [15:0] oled_data_init
    
    );
    // convert led_index to led_x and led_y begin
    
    wire [6:0] led_x;
    wire [5:0] led_y;
    
    assign led_x = pixel_index % 96;
    assign led_y = pixel_index / 96;
        
    // convert led_index to led_x and led_y end
    
    // anode 1 begin
    
    wire seg_1_0; wire seg_1_1; wire seg_1_2; wire seg_1_3; wire seg_1_4; wire seg_1_5; wire seg_1_6;
    
    assign seg_1_0 = ( ( led_x >= 2 ) &&  ( led_x <= 45 ) ) && ( ( led_y >= 2 )  && ( led_y <= 5 ) );
    assign seg_1_6 = ( ( led_x >= 2 ) &&  ( led_x <= 45 ) ) && ( ( led_y >= 30 ) && ( led_y <= 33 ) );
    assign seg_1_3 = ( ( led_x >= 2 ) &&  ( led_x <= 45 ) ) && ( ( led_y >= 58 ) && ( led_y <= 61 ) );
    
    assign seg_1_5 = ( ( led_x >= 2 ) &&  ( led_x <= 5 ) )  && ( ( led_y >= 2 )  && ( led_y <= 31 ) );
    assign seg_1_4 = ( ( led_x >= 2 ) &&  ( led_x <= 5 ) )  && ( ( led_y >= 32 ) && ( led_y <= 61 ) );
    
    assign seg_1_1 = ( ( led_x >= 42 ) &&  ( led_x <= 45 ) )&& ( ( led_y >= 2 )  && ( led_y <= 31 ) );
    assign seg_1_2 = ( ( led_x >= 42 ) &&  ( led_x <= 45 ) )&& ( ( led_y >= 32 ) && ( led_y <= 61 ) );
    
    // anode 1 end    

    // anode 0 begin
    
    wire seg_0_0; wire seg_0_1; wire seg_0_2; wire seg_0_3; wire seg_0_4; wire seg_0_5; wire seg_0_6;
    
    assign seg_0_0 = ( ( led_x >= 50 ) &&  ( led_x <= 93 ) ) && ( ( led_y >= 2 )  && ( led_y <= 5 ) );
    assign seg_0_6 = ( ( led_x >= 50 ) &&  ( led_x <= 93 ) ) && ( ( led_y >= 30 ) && ( led_y <= 33 ) );
    assign seg_0_3 = ( ( led_x >= 50 ) &&  ( led_x <= 93 ) ) && ( ( led_y >= 58 ) && ( led_y <= 61 ) );
    
    assign seg_0_5 = ( ( led_x >= 50 ) &&  ( led_x <= 53 ) )  && ( ( led_y >= 2 )  && ( led_y <= 31 ) );
    assign seg_0_4 = ( ( led_x >= 50 ) &&  ( led_x <= 53 ) )  && ( ( led_y >= 32 ) && ( led_y <= 61 ) );
    
    assign seg_0_1 = ( ( led_x >= 90 ) &&  ( led_x <= 93 ) )&& ( ( led_y >= 2 )  && ( led_y <= 31 ) );
    assign seg_0_2 = ( ( led_x >= 90 ) &&  ( led_x <= 93 ) )&& ( ( led_y >= 32 ) && ( led_y <= 61 ) );
    
    // anode 0 end
    
    always @(posedge clock_100mhz) begin
        
        if ( seg_1_0 || seg_1_1 || seg_1_2 || seg_1_3 || seg_1_4 || seg_1_5 ) begin
            
            oled_data_init <= 16'hFFFF;
            
        end else if ( seg_0_1 || seg_0_2 || seg_0_5 || seg_0_6 ) begin
            
            oled_data_init <= 16'hFFFF;
            
        end else begin
            
            oled_data_init <= 16'd0;
            
        end
        
    end
    
endmodule
