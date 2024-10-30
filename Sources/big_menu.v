`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2024 09:07:00 PM
// Design Name: 
// Module Name: big_menu
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


module big_menu(
input clock_100mhz,
    input btnC, btnU, btnD, btnL, btnR,
    input wire [12:0] pixel_index,
    input game_active,
    input [31:0] counter_RNG,
    output reg  [15:0] oled_data_menu,
    output reg mode,
    output reg difficulty,
    output reg start_game = 0,
    output reg [15:0] chassis_color = 16'd2016,
    output reg [15:0] wheel_color = 16'd2016,
    output reg [31:0] seed_RNG = 32'd1
    );
    
    reg [3:0] state = 4'b0000;
    
    reg [1:0] arrow_home = 0;
    reg [1:0] arrow_mode = 0;
    reg [1:0] arrow_stagediff = 0;
    reg [1:0] arrow_endlessdiff = 0;
    reg [1:0] arrow_carcolor = 0;
    reg arrow_chassis = 0;
    reg arrow_wheel = 0;
   
   //localparam
   localparam GREEN = 16'd2016;
   localparam BLUE = 16'd31;
    
   //instantiate homepage
    wire [15:0] oled_data_home;

    home_page homepage( .clock_100mhz(clock_100mhz), .pixel_index_home(pixel_index), .arrow_home(arrow_home), .oled_data_home(oled_data_home) );
    
    //instantiate select mode
    wire [15:0] oled_data_mode;
    
    select_mode chooseamode( .clock_100mhz(clock_100mhz), .pixel_index_mode(pixel_index), .arrow_mode(arrow_mode), .oled_data_mode(oled_data_mode) );
     
    //instantiate stage difficulty selection
    wire [15:0] oled_data_stagediff;
     
    stage_select_difficulty stagediff( .clock_100mhz(clock_100mhz), .pixel_index_stagediff(pixel_index), .arrow_stagediff(arrow_stagediff), .oled_data_stagediff(oled_data_stagediff) );
    
    //instatiate endless difficulty selection
    wire [15:0] oled_data_endlessdiff;
    endless_diff endlessdiff(.clock_100mhz(clock_100mhz),.pixel_index_endlessdiff(pixel_index),.arrow_endlessdiff(arrow_endlessdiff), 
    .oled_data_endlessdiff(oled_data_endlessdiff) );
    
    // instantiate car_color page
    wire [15:0] oled_data_carcolor;
    car_color choosecolor(.clock_100mhz(clock_100mhz), .pixel_index_car(pixel_index), .arrow_carcolor(arrow_carcolor), .oled_data_carcolor(oled_data_carcolor));
        
    //instantiate chassis color
    wire [15:0] oled_data_chassiscolor;
    chassis_color colorofchassis( .clock_100mhz(clock_100mhz), .pixel_index_chassiscolor(pixel_index), .arrow_chassis(arrow_chassis), .chassis_color(chassis_color), .oled_data_chassiscolor(oled_data_chassiscolor));
     
    //instantiate wheel color
    wire [15:0] oled_data_wheelcolor;
    wheel_color colorofwheel(.clock_100mhz(clock_100mhz),.pixel_index_wheelcolor(pixel_index), .arrow_wheel(arrow_wheel), .wheel_color(wheel_color),.oled_data_wheelcolor(oled_data_wheelcolor));
    
    always @(posedge clock_100mhz) begin
        
        if ( game_active ) begin
            
            state <= 4'b0000;
            
            arrow_home <= 0;
            arrow_mode <= 0;
            arrow_stagediff <= 0;
            arrow_endlessdiff <= 0;
            arrow_chassis <= 0;
            arrow_wheel <= 0;
            
        end else begin
        
            if ( state == 4'b0000 ) begin //home
                
                if ( btnU ) begin
                    
                    arrow_home <= 1;
                    
                end else if ( btnD ) begin
                    
                    arrow_home <= 2;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_home == 1 ) begin
                        
                        state <= 4'b0001;
                        
                    end else if ( arrow_home == 2 ) begin
                        
                        state <= 4'b0010;
                        
                    end
                    
                end
                
            end else begin
                
                arrow_home <= 0;
                
            end 
            
            if ( state == 4'b0001 ) begin // select mode
                
                if ( btnU ) begin
                    
                    arrow_mode <= 1;
                    
                end else if ( btnD ) begin
                    
                    arrow_mode <= 2;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_mode == 1 ) begin
                        
                        state <= 4'b0011; //stage
                        
                    end else if ( arrow_mode == 2 ) begin
                        
                        state <= 4'b0100;  //endless
                        
                    end
                    
                end
                
            end else begin
                
                arrow_mode <= 0;
                
            end 
            
            if ( state == 4'b0010 ) begin //car color
                
                if ( btnU ) begin
                    
                    arrow_carcolor <= 1;
                    
                end else if ( btnD ) begin
                    
                    arrow_carcolor <= 2;
                    
                end else if ( btnL ) begin
                    
                    arrow_carcolor <=3;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_carcolor == 1 ) begin
                        
                        state <= 4'b1001; //chassis color
                        
                    end else if ( arrow_carcolor == 2 ) begin
                        
                        state <= 4'b1010; // wheel color
                        
                    end else if ( arrow_carcolor == 3 ) begin
                        
                        state <= 4'b0000; //home
                        
                    end
                    
                end
                
            end else begin
                
                arrow_carcolor <= 0;
                
            end
            
            if ( state == 4'b0011 ) begin // stage select difficulty
                
                if ( btnU ) begin
                    
                    arrow_stagediff <= 1;
                    
                end else if ( btnD ) begin
                    
                    arrow_stagediff <= 2;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_stagediff == 1 ) begin
                        
                        state <= 4'b0101; //easy
                        
                    end else if ( arrow_stagediff == 2) begin
                        
                        state <= 4'b0110; //hard
                        
                    end
                    
                end
                
            end else begin
                
                arrow_stagediff <= 0;
                
            end
            
            if ( state == 4'b0100 ) begin // endless select difficulty 
                
                if ( btnU ) begin
                
                arrow_endlessdiff <= 1;
                
                end else if ( btnD ) begin
                    
                    arrow_endlessdiff <= 2;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_endlessdiff == 1 ) begin
                        
                        state <= 4'b0111; //easy
                        
                    end else if ( arrow_endlessdiff == 2) begin
                        
                        state <= 4'b1000; //hard
                    
                    end
                
                end
             
            end else begin
                
                arrow_endlessdiff <= 0;
                
            end
            
            if ( state == 4'b1001 ) begin //chassis color
                
                if ( btnL ) begin
                    
                    chassis_color <= GREEN;
                    arrow_chassis <= 0;
                    
                end else if ( btnR ) begin
                    
                    chassis_color <= BLUE;
                    arrow_chassis <= 0;
                    
                end else if ( btnD ) begin
                    
                    arrow_chassis <= 1;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_chassis == 1 ) begin
                        
                        state <= 4'b0010; //car color
                        
                    end
                    
                end
                    
            end else begin
                
                arrow_chassis <= 0;
                
            end
            
            if ( state == 4'b1010 ) begin //wheel color
                
                if ( btnL ) begin
                    
                    wheel_color <= GREEN;
                    arrow_wheel <= 0;
                    
                end else if ( btnR ) begin
                    
                    wheel_color <= BLUE;
                    arrow_wheel <= 0;
                    
                end else if ( btnD ) begin
                    
                    arrow_wheel <= 1;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_wheel == 1 ) begin
                        
                        state <= 4'b0010; // car color
                        
                    end
                    
                end
                
            end else begin
                
                arrow_wheel <= 0;
                
            end
        
        end
     
    end
     
    always @(posedge clock_100mhz) begin
    
        if (state==4'b0000) begin //home
            
            oled_data_menu <= oled_data_home;
            
            start_game<=0;
            
        end else if (state==4'b0001) begin //start
            
            oled_data_menu <= oled_data_mode;
            
            seed_RNG <= counter_RNG;
            
        end else if (state==4'b0010) begin //color
        
            oled_data_menu <= oled_data_carcolor;
            
        end else if (state==4'b0011) begin //stage
            
            oled_data_menu <=oled_data_stagediff;
            
        end else if (state==4'b0100) begin //endless
            
            oled_data_menu <= oled_data_endlessdiff;
            
        end else if (state==4'b0101) begin //stage easy
            
            start_game<=1;
            
            mode <= 0;
            
            difficulty <= 0;
            
        end else if (state==4'b0110) begin //stage hard
            
            start_game<=1;
            
            mode <= 0;
            
            difficulty <= 1;
        
        end else if (state==4'b0111) begin //endless easy 
        
            start_game<=1;
            
            mode <= 1;
            
            difficulty <= 0;
       
        end else if (state==4'b1000) begin //endless hard
        
            start_game<=1;
            
            mode <= 1;
            
            difficulty <= 1;
                    
        end else if (state==4'b1001) begin //chassis color
            
            oled_data_menu <= oled_data_chassiscolor;
            
        end else if (state==4'b1010) begin //wheel color
            
            oled_data_menu <= oled_data_wheelcolor;
            
        end else begin
            
            oled_data_menu <= oled_data_menu;
            
        end
        
    end

endmodule
