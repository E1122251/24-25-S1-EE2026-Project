`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: Kim Joohyung
//  STUDENT B NAME: Aryan Dubey
//  STUDENT C NAME: Lim Jia En
//  STUDENT D NAME: Lam Zhe Yu Isaac
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    
    input clock_100mhz,
    
    input [15:0] sw,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    output reg [15:0] led,
    
    output reg [7:0] seg,
    output reg [3:0] an,
    
    output wire [7:0] JB
    
    );
    
    // define passwords begin
    
    wire game_active;
    
    assign game_active = ( sw[15] == 1 );
    
    // define passwords end
    
    // instantiate Oled_Display begin
    
    wire clock_6p25mhz;
    
    clock_variable_gen clock_6p25mhz_gen ( .clock_100mhz(clock_100mhz), .m(32'd7), .clock_output(clock_6p25mhz) );
    
    wire frame_begin;
    wire sending_pixels;
    wire sample_pixel;
    wire [12:0] pixel_index;
    
    reg [15:0] oled_data;
    
    Oled_Display disp_oled ( 
          
        .clk(clock_6p25mhz), 
        .reset(0),
          
        .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel),
        
        .pixel_index(pixel_index),
          
        .pixel_data(oled_data),
          
        .cs(JB[0]),
        .sdin(JB[1]),
        .sclk(JB[3]),
        .d_cn(JB[4]),
        .resn(JB[5]),
        .vccen(JB[6]),
        .pmoden(JB[7])
          
        );    
    
    assign JB[2] = 1'b0;
    
    // instantiate Oled_Display end
    
    // instantiate game begin
    
    wire [15:0] led_game;
    
    wire [7:0] seg_game;
    wire [3:0] an_game;
     
    wire [15:0] oled_data_game;
    
    game game_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .sw(sw),
        
        .btnC(btnC),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .pixel_index(pixel_index),
        
        .game_active(game_active),
        
        .led_game(led_game),
        
        .seg_game(seg_game),
        .an_game(an_game),
        
        .oled_data_game(oled_data_game)
        
        );
    
    // instantiate game end
    
    
    // always block to assign led and oled_data begin
    
    always @(posedge clock_100mhz) begin
        
        if ( game_active ) begin
            
            led <= led_game;
            
            seg <= seg_game;
            an <= an_game;
            
            oled_data <= oled_data_game;
            
        end else begin
            
            led <= sw;
            
            seg <= ~8'b0000_0000;
            an <= ~4'b0000;
            
            oled_data <= 0;
            
        end
        
    end
    
    // always block to assign led and oled_data end
    
    endmodule
    