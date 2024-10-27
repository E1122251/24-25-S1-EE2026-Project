`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2024 08:17:05 PM
// Design Name: 
// Module Name: endless_diff
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


module endless_diff(
input clock_100mhz,
    input [12:0] pixel_index_endlessdiff,
    input [1:0] arrow_endlessdiff,
    output reg [15:0] oled_data_endlessdiff

    );
         //coordinates
    wire [6:0]x;
    wire [5:0]y;
    assign x = (pixel_index_endlessdiff%96);
    assign y = (pixel_index_endlessdiff/96);
    
    localparam RED = 16'd63488;
    localparam BLACK = 16'd0;
    localparam WHITE = 16'b1111111111111111;
    localparam arrow_color = 16'b1110110011100011;
      
    wire EASY; wire HARD; wire ENDLESS;
    
    
    assign ENDLESS = ((x>=24 & x<=30 & y>=0 & y<=1) | (x>=24 & x<=30 & y>=5 & y<=6)|(x>=24 & x<=25 & y>=0 & y<=6)|(x>=24 & x<=28 & y==3) //E
    | (x>=32 & x<=33 & y>=0 & y<=6) |(x>=37 & x<=38 &  y>=0 & y<=6)| (x==34 & y>=1 & y<=2) | (x==35 & y>=2 & y<=3) | (x==36 & y>=3 & y<=4) //N
    | (x>=40 & x<=41 &  y>=0 & y<=6)| (x>=42 & x<=44 &y>=0 & y<=1)|(x>=42 & x<=44 & y>=5 & y<=6)| (x>=45 & x<=46 & y>=2 & y<=4) //D
    | (x>=48 & x<=49 &  y>=0 & y<=6)| (x>=48 & x<=54 & y>=5 & y<=6) //L
    | (x>=56 & x<=62 &  y>=0 & y<=1) | (x>=56 & x<=62 & y>=5 & y<=6)|(x>=56 & x<=57 & y>=0 & y<=6)|(x>=58 & x<=60 & y==3) //E
    | (x>=65 & x<=70 & y>=0 & y<=1) | (x==64 & y==2) | (x>=65 & x<=69 & y==3) | (x==70 & y==4) |(x>=64 & x<=69 & y>=5 & y<=6) //S
    | (x>=73 & x<=78 & y>=0 & y<=1) | (x==72 & y==2) | (x>=73 & x<=77 & y==3) | (x==78 & y==4) |(x>=72 & x<=77 & y>=5 & y<=6) //S
    );
    
    
    assign EASY = ((x>=32 & x<=33 & y>=40 & y<=46) | (x>=32 & x<=38 & y>=40 & y<=41) | (x>=32 & x<=38 & y>=45 & y<=46) | (x>=34 & x<=36 & y==43) //E
| ( x>=42 & x<=44 & y>=40 & y<=41) | (x>=40 & x<=41 & y>=41 & y<=46) | (x>=45 & x<=46 & y>=41 & y<=46) | (x>=42 & x<=44 & y==44 ) //A
| (x>=49 & x<=54 & y>= 40 & y <=41) | (x==48 & y==42) | (x>=49 & x<=53 & y==43) | (x==54 & y==44) | (x>=48& x<=53 & y>=45 & y<=46) //S
| (x==56 & y>=40 & y<=41) | (x==57 & y>=41 & y<=42) | (x==58 & y>=42 & y<=43)|(x==59 & y>=43 & y<=46)| (x==60 & y>=42 & y<=43)|(x==61 & y>=41 & y<=42)|(x==62 & y>=40 & y<=41)
); //Y

    assign HARD = ((x>=32 & x<=33 & y>=48 & y<=54) | (x>=37 & x<=38 & y>=48 & y<=54) |  (x>=34 & x<=36 & y==51) //H
| ( x>=42 & x<=44 & y>=48 & y<=49) | (x>=40 & x<=41 & y>=49 & y<=54) | (x>=45 & x<=46 & y>=49 & y<=54) | (x>=42 & x<=44 & y==52 ) //A
| (x>=48 & x<=49 & y>=48 & y<=54) | ( x>=50 & x<=53 & y>=48 & y<=49) |( x>=50 & x<=53 & y>=51 & y<=52) | (x==54 & y==50) | (x==54 & y==54) | (x==53 & y==53) //R
| (x>=56 & x<=57 & y>=48 & y<=54) | (x>=58 & x<=61 & y>=48 & y<=49) | (x>=58 & x<=61 & y>=53 & y<=54) |(x>=61 & x<=62 & y>=49 & y<=53) //D
);

     wire arrow_EASY; wire arrow_HARD;
     assign arrow_EASY = ((x==25 &  y>=40 & y<=46) | (x==26 &  y>=41 & y<=45)| (x==27 & y>=42& y<=44)| (x==28 & y==43));
     assign arrow_HARD = ((x==25 &  y>=48 & y<=54) | (x==26 &  y>=49 & y<=53)| (x==27 & y>=50 & y<=52)| (x==28 & y==51));
     
          //colors
          always @(posedge clock_100mhz) begin
            if (ENDLESS) begin
                oled_data_endlessdiff<=RED;
                end
            else if (EASY) begin
                oled_data_endlessdiff<= WHITE;
                end
            else if (HARD) begin
                oled_data_endlessdiff<= WHITE;
                end  
            else if ( ( arrow_endlessdiff == 1 ) && ( arrow_EASY ) ) begin
                oled_data_endlessdiff<= arrow_color;
                end       
            else if ( ( arrow_endlessdiff == 2 ) && ( arrow_HARD ) ) begin
                oled_data_endlessdiff<= arrow_color;
                end
            else begin
               oled_data_endlessdiff <= BLACK;
                end
            end   
endmodule
