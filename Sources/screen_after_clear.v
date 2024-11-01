`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 12:51:34 AM
// Design Name: 
// Module Name: screen_game_clear
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


module screen_game_clear(
    input clock_100mhz,
    input [12:0] pixel_index,
    input game_active,
    input mode,
    input difficulty,
    input [13:0] score,
    input btnC,
    
    output reg toggle_game_clear_screen = 0,
    output reg [15:0] oled_data_game_clear,
    output reg return_to_logic = 0
    );

    wire [6:0] x = pixel_index % 96;
    wire [5:0] y = pixel_index / 96;
    always @ (posedge clock_100mhz) begin
        if (game_active == 1 && mode == 0) begin
            if (difficulty == 0 && score >= 20) begin
                toggle_game_clear_screen <= 1;
                end
            else if (difficulty == 1 && score >= 100) begin
                toggle_game_clear_screen <= 1;
                end              
        end
        else begin
            toggle_game_clear_screen <= 0;
            return_to_logic <= 0;
            end
        if (toggle_game_clear_screen == 1) begin
                if (btnC ==1) begin
                    return_to_logic <= 1;
                end
                if (//YOU WIN!
                (x>=11 & x<=12 & y>=19 & y<=20) | (x>=12 & x<=13 & y>=20 & y<=21)| (x>=13 & x<=14 & y>=21 & y<=22)| (x>=15 & x<=16 & y>=21 & y<=22) | (x>=16 & x<=17 & y>=20 & y<=21 |(x>=17 & x<=18 & y>=19 & y<=20)|(x>=14 & x<=15 & y>=21 & y<=27))//Y
                | (x>=21 & x<=22 & y>=20 & y<=26) |(x>=26 & x<=27 & y>=20 & y<=26) |(x>=23 & x<=25 & y>=19 & y<=20) |(x>=23 & x<=25 & y>=26 & y<=27) //O
                | (x>=30 & x<=31 & y>=19 & y<=27) |(x>=35 & x<=36 & y>=19 & y<=27) |(x>=31 & x<=34 & y>=26 & y<=27) //U
                | (x>=46 & x<=47 & y>=19 & y<=25) |(x>=50 & x<=51 & y>=20 & y<=25) |(x>=54 & x<=55 & y>=19 & y<=25)|(x>=47 & x<=54 & y>=25 & y<=26)|(x>=48 & x<=49 & y==27)|(x>=52 & x<=53 & y==27)//W
                | (x>=58 & x<=59 & y>=19 & y<=27)//I
                | (x>=62 & x<=63 & y>=19 & y<=27) | (x>=67 & x<=68 & y>=19 & y<=27) |(x==64 & y>=21 & y<=22)|(x==65 & y>=22 & y<=23)|(x==66 & y>=23 & y<=24) //N
                | (x>=71 & x<=72 & y>=19 & y<=24) |(x>=71 & x<=72 & y>=26 & y<=27) //!
               
                //RESTART GAME
                | (x>=19 & x<=21 & y==42 ) | (x==18 & y>=43 & y<=48)| (x>=19 & x<=21 & y==45)| (x==22 & y>=43 & y<=45) | (x==20 & y==46)| (x==21 & y==47)| (x==22 & y==48)//R
                | (x>=25 & x<=28 & y==42) | (x>=25 & x<=28 & y==45) | (x>=25 & x<=28 & y==48)|(x==24 & y>=43 & y<=47) //E
                | (x>=31 & x<=34 & y==42)|(x>=31 & x<=33 & y==45)|(x>=30 & x<=34 & y==48)|(x==30 & y>=43 & y<=44) |(x==34 & y>=46 & y<=47) //S
                | (x>=36 & x<=40 & y==42) |(x==38  & y>=42 & y<=48)//T
                | (x>=43 & x<=45 & y==42) |(x>=43 & x<=45 & y==45) |(x==42 &  y>=43 & y<=48) |(x==46 &  y>=43 & y<=48)//A
                | (x>=49 & x<=51 & y==42 ) | (x==48 & y>=43 & y<=48)| (x>=49 & x<=51 & y==45)| (x==52 & y>=43 & y<=45) | (x==50 & y==46)| (x==51 & y==47)| (x==52 & y==48) //R
                | (x>=54 & x<=58 & y==42) |(x==56  & y>=42 & y<=48)//T
                | (x>=63 & x<=66 & y==42)  |(x==62 & y>=43 & y<=47) |(x>=63 & x<=65 & y==48) | (x==66 & y==43) | (x==66 & y>=45 & y<=47) | (x==65 & y==45)//G
                | (x>=69 & x<=71 & y==42) |(x>=69 & x<=71 & y==45) |(x==68 &  y>=43 & y<=48) |(x==72 &  y>=43 & y<=48) //A   
                | (x==74 & y>=42 & y<=48)| (x==79 & y>=42 & y<=48)|(x==75 & y==43) | ( x== 78 & y==43)|(x>=76 & x<=77 & y==44) //M
                | (x>=82 & x<=85 & y==42) | (x>=82 & x<=85 & y==45) | (x>=82 & x<=85 & y==48)|(x==81 & y>=43 & y<=47) //E
                )begin
                    oled_data_game_clear <= 16'hFFFF;
                    end
                else if ((x==11 & y>=42 & y<=48) | (x==12 & y>=43 & y<=47) | (x==13 & y>=44 & y<=46) | (x==14 & y==45) 
                ) begin
                    oled_data_game_clear <= 16'hECE3;
                end
                else begin
                    oled_data_game_clear <= 16'h0000;
                end
        end
    end
endmodule
