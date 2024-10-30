`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 08:10:08 PM
// Design Name: 
// Module Name: wheel_color
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


module wheel_color(
input clock_100mhz,
    input arrow_wheel,
    input [12:0] pixel_index_wheelcolor,
    input [15:0] wheel_color, 
    output reg [15:0] oled_data_wheelcolor
    );
    
     //coordinates
     wire [6:0]x;
     wire [5:0]y;
     assign x = (pixel_index_wheelcolor%96);
     assign y = (pixel_index_wheelcolor/96); 
     
    localparam RED = 16'd63488;
    localparam BLACK = 16'd0;
    localparam WHITE = 16'b1111111111111111;
    localparam arrow_color = 16'b1110110011100011;
    localparam green = 16'b0000010000100000;
    localparam blue = 16'b0000010000111111;
    
    localparam gold = 16'b1110111000100001; 
    localparam silver = 16'b1101111011111011; 
    localparam pink = 16'b1111100111110111; 
    
    wire WHEELS; wire CONFIRM; wire PINK; wire GOLD; wire SILVER;wire arrow_CONFIRM;
    
     assign WHEELS = ( (x>=24 & x<=25 & y>=0 & y<=6) | (x>=29 & x<=30 & y>=0 & y<=6) | (x==26 & y>=4 & y<=5) | (x==27 & y>=3 & y<=4) |(x==28 & y>=4 & y<=5) //@
     | (x>=32 & x<=33 & y>=0 & y<=6) | (x>=37 & x<=38 & y>=0 & y<=6) | (x>=34 & x<=36 & y==3) //H
     | (x>=40 & x<=41 & y>=0 & y<=6) | (x>=42 & x<=46 & y>=0 & y<=1) | (x>=42 & x<=46 & y>=5 & y<=6) | (x>=42 & x<=44 & y==3) //E
     | (x>=48 & x<=49 & y>=0 & y<=6) | (x>=50 & x<=54 & y>=0 & y<=1) | (x>=50 & x<=54 & y>=5 & y<=6) | (x>=50 & x<=52 & y==3) //E
     | (x>=56 & x<=57 & y>=0 & y<=6) | (x>=56 & x<=62 & y>=5 & y<=6) //L
     | (x>=65 & x<=70 & y>=0 & y<=1) | (x>=64 & x<=69 & y>=5 & y<=6) | (x==64 & y==2) | (x==70 & y==4) | (x>=65 & x<=69 & y==3) //S
     );
     
//     assign GOLD = ( (x==32 & y>=26 & y<=28) | (x>=33 & x<=38 & y>=24 & y<=25) | (x>=33 & x<=38 & y>=29 & y<=30) | (x==39 & y==29) | (x>=35 & x<=38 & y==27) //G
//     | (x>=41 & x<=45 & y>=24 & y<=25) | (x>=41 & x<=45 & y>=29 & y<=30) | (x>=40 & x<=41 & y>=25 & y<=29) | (x>=45 & x<=46 & y>=25 & y<=29) //O
//     | (x>=48 & x<=49 & y>=24 & y<=30) | (x>=48 & x<=54 & y>=29 & y<=30) //L
//     | (x>=56 & x<=57 & y>=24 & y<=30) | (x>=56 & x<=61 &y>=24 & y<=25) | (x>=56 & x<=61 & y>=29 & y<=30) | (x>=61 & x<=62 & y>=25 & y<=29) //D
//     );
     
//     assign SILVER = ( (x>=25 & x<=30 & y>=24 & y<=25) | (x>=24 & x<=29 & y>=29 & y<=30) | (x==24 & y==26) | (x==30 & y==28) | (x>=25 & x<=29 & y==27) //S
//     | (x>=32 & x<=38 & y>=24 & y<=25) | (x>=32 & x<=38 & y>=29 & y<=30) | (x==35 & y>=26 & y<=28) |
//     | (x>=40 & x<=41 & y>=24 & y<=30) | (x>=42 & x<=46 & y>=29 & y<=30) //L
//     | (x==48 & y>=24 & y<=26) | (x==54 & y>=24 & y<=26) | (x==49 & y>=26 & y<=28) | (x==53 & y>=26 & y<=28) |( x==50 & y>=28 & y<=29) | (x==52 & y>=28 & y<=29) | (x==51 & y==30) //V
//     | (x>=56 & x<=57 & y>=24 & y<=30)  | (x>=58 & x<=62 & y>=24 & y<=25) | (x>=58 & x<=62 & y>=29 & y<=30) | (x>=58 & x<=60 & y==27) //E
//     | (x>=64 & x<=65 & y>=24 & y<=30) | (x>=66 & x<=69 & y>=24 & y<=25) | (x>=65 & x<=69 & y>=27 & y<=28) | (x==70 & y==26) | (x==70 & y==30) | (x==69 & y==29) //R
//     );
     
     
//     assign PINK = ( (x>=32 & x<=33 & y>=24 & y<=30) | (x>=34 & x<=37 & y==24) | (x>=34 & x<=37 & y==27) | (x==38 & y>=25 & y<=26) //P
//     | (x>=40 & x<=46 & y>=24 & y<=25) | (x>=40 & x<=46 & y>=29 & y<=30) | (x==43 & y>=26 & y<=28) //I
//     | (x>=28 & x<=49 & y>=24 & y<=30) | (x>=53 & x<=54 & y>=24 & y<=30) | (x==50 & y>=25 & y<=26) | (x==51 & y>=26 & y<=27) |  (x==52 & y>=27 & y<=28) //N
//     | (x>=56 & x<=57 & y>+24 & y<=30) | (x>=58 & x<=59 & y==27) | (x==62 & y==24) | (x==62 & y==30) | (x==61 & y==25) | (x==61 & y==29) | (x==60 & y==26) | (x==60 & y==28) //K
//     );
    wire GREEN; wire BLUE;
   assign GREEN = ( (x==32 & y>=26 & y<=28) | (x>=33 & x<=38 & y>=24 & y<=25) | (x>=33 & x<=38 & y>=29 & y<=30) | (x==38 & y==28) | (x>=35 & x<=38 & y==27) //G
        | (x>=40 & x<=41 & y>=24 & y<=30) | (x>=42 & x<=45 & y>=24 & y<=25) | (x>=42 & x<=45 & y>=27 & y<=28) | (x==46 & y==26) |(x==46 & y==30) |(x==45 & y==29) //R
        | (x>=48 & x<=49 & y>= 24 & y<=30) | (x>=50 & x<=54 & y>=24 & y<=25) | (x>=50 & x<=54 & y>=29 & y<=30) | ( x>=50 & x<=52 & y==27) // E
        | (x>=56 & x<=57 & y>= 24 & y<=30) | (x>=58 & x<=62 & y>=24 & y<=25) | (x>=58 & x<=62 & y>=29 & y<=30) | ( x>=58 & x<=60 & y==27) // E
        | (x>=64 & x<=65 & y>=24 & y<=30) | (x>=69 & x<=70 & y>=24 & y<=30) | (x==66 & y>=25 & y<=26) | (x==67 & y>=26 & y<=27) | (x==68 & y>=27 & y<=28) //N
    );
    
    assign BLUE = ( ( x>=32 & x<=33 & y>=24 & y<=30) | (x>=34 & x<=37 & y>=24 & y<=25) | (x>=34 & x<=37 & y>=29 & y<=30)| (x>=34 & x<=37  & y==27) | (x==38 & y>=25 & y<=26) | (x==38 & y>=28 & y<=29) //B
    | (x>=40 & x<=41 & y>=24 & y<=30) | (x>=42 & x<=46 & y>=29 & y<=30) // L 
    | (x>=48 & x<=49 & y>=24 & y<=29) | (x>=53 & x<=54 & y>=24 & y<=29) | (x>=49 & x<=53 & y>=29 & y<=30) //U
    | (x>=56 & x<=57 & y>=24 & y<=30) | (x>=58 & x<=62 & y>= 24 & y<=25)| (x>=58 & x<=62 & y>= 29 & y<=30) | (x>=58 & x<=60 & y==27) //E
    );
     assign arrow_CONFIRM = ((x==17 &  y>=48 & y<=54) | (x==18 &  y>=49 & y<=53)| (x==19 & y>=50& y<=52)| (x==20 & y==51));
    
     assign CONFIRM = ( (x>=24 & x<=25 & y>=50 & y<=52) | (x>= 26 & x<=30 & y>=48 & y<=49) | (x>=26 & x<=30 & y>=53 & y<=54) //C
         | (x>=33 & x<=37 & y>=48 & y<=49) | (x>=33 & x<=37 & y>=53 & y<=54) | (x>=32 & x<=33 & y>=49 & y<=53) | (x>=37 & x<=38 & y>=49 & y<=53) //O
         | (x>=40 & x<=41 & y>=48 & y<=54) | (x>=45 & x<=46 & y>=48 & y<=54) | (x==42 & y>=49 & y<=50) | (x==43 & y>=50 & y<=51) | (x==44 & y>=51 & y<=52) //N
         | (x>=48 & x<=49 & y>=48 & y<=54) | (x>=50 & x<=54 & y>=48 & y<=49) | (x>=50 & x<=52 & y==51) //F
         | (x>=56 & x<=62 & y>=48 & y<=49) | (x>=56 & x<=62 & y>=53 & y<=54) | (x==59 & y>=50 & y<=52) //I
         | (x>=64 & x<=65 & y>=48 & y<=54) | (x>=66 & x<=69 & y>=48 & y<=49) | (x>=66 & x<=69 & y>=51 & y<=52) | (x==70 & y==50) | (x==70 & x==54) | (x==69 & y==53) //R
         |(x>=72 & x<=73 & y>=48 & y<=54)  | (x>=77 & x<=78 & y>=48 & y<=54) | (x==74 & y>=49 & y<=50) | (x==75 & y>=50 & y<=51) | (x==76 & y>=49 & y<=50) //M
         );
  
   
   always @(posedge clock_100mhz) begin
    if (arrow_CONFIRM && arrow_wheel) begin
        oled_data_wheelcolor <= arrow_color;
    end else if (CONFIRM) begin
        oled_data_wheelcolor <= WHITE;
    end else if (WHEELS) begin
        oled_data_wheelcolor <=RED;
    end else if (GREEN && (wheel_color==16'd2016)) begin
        oled_data_wheelcolor <= green;
    end else if (BLUE && (wheel_color==16'd31)) begin
        oled_data_wheelcolor <=blue;
//    end else if (SILVER && (wheel_color==3'b000)) begin
//        oled_data_wheelcolor <=silver;
//    end else if (GOLD && (wheel_color==3'b001)) begin
//        oled_data_wheelcolor <= gold;
//    end else if (PINK && (wheel_color==3'b010)) begin
//        oled_data_wheelcolor <= pink;
    end else begin
        oled_data_wheelcolor <=BLACK;
        end    
    end
endmodule
