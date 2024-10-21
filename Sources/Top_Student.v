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
    
    // debounce btns begin
    
    wire btnC_db; wire btnU_db; wire btnL_db; wire btnR_db; wire btnD_db;
    
    debounce_pbs debounce_pbs_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnC(btnC), .btnU(btnU), .btnL(btnL), .btnR(btnR), .btnD(btnD),
        
        .btnC_db(btnC_db), .btnU_db(btnU_db), .btnL_db(btnL_db), .btnR_db(btnR_db), .btnD_db(btnD_db)
        
        );
    
    // debounce btns end
    
    
    // declare game_active begin
    
    reg game_active = 0;
    
    // declare game_active end
    
    
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
    
    
    // instantiate menu begin
    
    wire [15:0] oled_data_menu;
    wire start_game;
    
    big_menu big_menu_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnC(btnC_db),
        .btnU(btnU_db),
        .btnD(btnD_db),
        
        .pixel_index(pixel_index),
        
        .oled_data_menu(oled_data_menu),
        
        .start_game(start_game)
                
        );
        
    // instantiate menu end
    
    
    // instantiate game begin
    
    wire [15:0] led_game;
    
    wire [7:0] seg_game;
    wire [3:0] an_game;
     
    wire [15:0] oled_data_game;
    
    game game_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .sw(sw),
        
        .btnC(btnC_db),
        .btnU(btnU_db),
        .btnL(btnL_db),
        .btnR(btnR_db),
        .btnD(btnD_db),
        
        .pixel_index(pixel_index),
        
        .game_active(game_active),
        
        .led_game(led_game),
        
        .seg_game(seg_game),
        .an_game(an_game),
        
        .oled_data_game(oled_data_game)
        
        );
    
    // instantiate game end
    
    
    // always block to control game_active begin
    
    always @(posedge clock_100mhz) begin
        
        if ( !game_active && start_game ) begin
            
            game_active <= 1;
            
        end
        
    end
    
    // always block to control game_active end
    
    
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
            
            oled_data <= oled_data_menu;
            
        end
        
    end
    
    // always block to assign led and oled_data end
    
endmodule
    