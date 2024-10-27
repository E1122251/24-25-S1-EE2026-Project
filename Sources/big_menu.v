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
    input btnC, btnU, btnD,
    input wire [12:0] pixel_index,
    input game_active,
    output reg  [15:0] oled_data_menu,
    output reg start_game = 0
    );
    
    reg [3:0] state = 4'b0000;
    
    reg [1:0] arrow_home = 0;
    reg [1:0] arrow_mode = 0;
    reg [1:0] arrow_stagediff = 0;
    reg [1:0] arrow_endlessdiff = 0;
    
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
    
     //instantiate car_color page
     //wire [15:0] oled_data_carcolor;
     //car_color choosecolor(.clock_100mhz(clock_100mhz), .pixel_index_car(pixel_index),.oled_data_carcolor(oled_data_carcolor));
     
     localparam RED = 16'd63488;
     localparam BLACK = 16'd0;
     localparam WHITE = 16'b1111111111111111;
     localparam arrow_color = 16'b1110110011100011;

     
    always @(posedge clock_100mhz) begin
        
        if ( game_active ) begin
            
            state <= 3'b000;
            
            arrow_home <= 0;
            arrow_mode <= 0;
            arrow_stagediff <= 0;
            arrow_endlessdiff <= 0;
            
        end else begin
        
            if ( state == 3'b000 ) begin //home
                
                if ( btnU ) begin
                    
                    arrow_home <= 1;
                    
                end else if ( btnD ) begin
                    
                    arrow_home <= 2;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_home == 1 ) begin
                        
                        state <= 3'b001;
                        
                    end else if ( arrow_home == 2 ) begin
                        
                        state <= 3'b010;
                        
                    end
                    
                end
                
            end else begin
                
                arrow_home <= 0;
                
            end 
            
            if ( state == 3'b001 ) begin // select mode
                
                if ( btnU ) begin
                    
                    arrow_mode <= 1;
                    
                end else if ( btnD ) begin
                    
                    arrow_mode <= 2;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_mode == 1 ) begin
                        
                        state <= 3'b011; //stage
                        
                    end else if ( arrow_mode == 2 ) begin
                        
                        state <= 3'b100;  //endless
                        
                    end
                    
                end
                
            end else begin
                
                arrow_mode <= 0;
                
            end 
            
            if ( state == 3'b011 ) begin // stage select difficulty
                
                if ( btnU ) begin
                    
                    arrow_stagediff <= 1;
                    
                end else if ( btnD ) begin
                    
                    arrow_stagediff <= 2;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_stagediff == 1 ) begin
                        
                        state <= 3'b101; //easy
                        
                    end else if ( arrow_stagediff == 2) begin
                        
                        state <= 3'b110; //hard
                        
                    end
                    
                end
                
            end else begin
                
                arrow_stagediff <= 0;
                
            end
            
            if ( state == 3'b100 ) begin // endless select difficulty 
                
                if ( btnU ) begin
                
                arrow_endlessdiff <= 1;
                
                end else if ( btnD ) begin
                    
                    arrow_endlessdiff <= 2;
                    
                end else if ( btnC ) begin
                    
                    if ( arrow_endlessdiff == 1 ) begin
                        
                        state <= 3'b111; //easy
                        
                    end else if ( arrow_endlessdiff == 2) begin
                        
                        state <= 4'b1000; //hard
                    
                    end
                
                end
             
            end else begin
                
                arrow_endlessdiff <= 0;
                
            end
        
        end
     
    end
     
    always @(posedge clock_100mhz) begin
    
        if (state==3'b000) begin //home
            
            oled_data_menu <= oled_data_home;
            
            start_game<=0;
            
        end else if (state==3'b001) begin //start
            
            oled_data_menu <= oled_data_mode;
            
        //end else if (state==3'b010) begin //color
        
            //oled_data_menu <= oled_data_carcolor;
            
        end else if (state==3'b011) begin //stage
            
            oled_data_menu <=oled_data_stagediff;
            
        end else if (state==3'b100) begin //endless
            
            oled_data_menu <= oled_data_endlessdiff;
            
        end else if (state==3'b101) begin //stage easy
            
            start_game<=1;
            
        end else if (state==3'b110) begin //stage hard
            
            start_game<=1;
        
        end else if (state==3'b111) begin //endless easy 
        
            start_game<=1;
       
        end else if (state==4'b1000) begin //endless hard
        
            start_game<=1;
                    
        end else begin
            
            oled_data_menu<=oled_data_menu;
            
        end
        
    end

endmodule
