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
    output reg  [15:0] oled_data_menu,
    output reg start_game = 0
    );
    
    reg [2:0] state = 3'b000;
    
    reg [1:0] arrow_home = 0;
    reg [1:0] arrow_mode = 0;
    reg [1:0] arrow_diff = 0;
    
       //instantiate homepage
    wire [15:0] oled_data_home;

    home_page homepage( .clock_100mhz(clock_100mhz), .pixel_index_home(pixel_index), .arrow_home(arrow_home), .oled_data_home(oled_data_home) );
    
    //instantiate select mode
    wire [15:0] oled_data_mode;
    
    select_mode chooseamode( .clock_100mhz(clock_100mhz), .pixel_index_mode(pixel_index), .arrow_mode(arrow_mode), .oled_data_mode(oled_data_mode) );
     
    //instantiate stage difficulty selection
    wire [15:0] oled_data_stagediff;
     
    stage_select_difficulty stagediff( .clock_100mhz(clock_100mhz), .pixel_index_stagediff(pixel_index), .arrow_diff(arrow_diff), .oled_data_stagediff(oled_data_stagediff) );
     
         localparam WHITE = 16'b1111111111111111;

     
    always @(posedge clock_100mhz) begin
        
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
            
        end 
        
        if ( state == 3'b001 ) begin // select mode
            
            if ( btnU ) begin
                
                arrow_mode <= 1;
                
            end else if ( btnD ) begin
                
                arrow_mode <= 2;
                
            end else if ( btnC ) begin
                
                if ( arrow_mode == 1 ) begin
                    
                    state <= 3'b011;
                    
                end else if ( arrow_mode == 2 ) begin
                    
                    state <= 3'b011;
                    
                end
                
            end
            
        end 
        
        if ( state == 3'b011 ) begin // stage select difficulty
            
            if ( btnU ) begin
                
                arrow_diff <= 1;
                
            end else if ( btnD ) begin
                
                arrow_diff <= 2;
                
            end else if ( btnC ) begin
                
                if ( arrow_diff == 1 ) begin
                    
                    state <= 3'b101;
                    
                end else if ( arrow_diff == 2) begin
                    
                    state <= 3'b110;
                    
                end
                
            end
            
        end
        
    end
     
    always @(posedge clock_100mhz) begin
    
        if (state==3'b000) begin
            
            oled_data_menu <= oled_data_home;
            
        end else if (state==3'b001) begin
            
            oled_data_menu <= oled_data_mode;
            
        end else if (state==3'b010) begin
        
            oled_data_menu <= WHITE;
            
        end else if (state==3'b011) begin
            
            oled_data_menu <=oled_data_stagediff;
            
        end else if (state==3'b100) begin
            
            oled_data_menu <= WHITE;
            
        end else if (state==3'b101) begin
            
            start_game<=1;
            
        end else if (state==3'b110) begin
            
            start_game<=1;
            
        end else begin
            
            oled_data_menu<=oled_data_menu;
            
        end
        
    end

endmodule
