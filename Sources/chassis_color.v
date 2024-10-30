`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 08:09:58 PM
// Design Name: 
// Module Name: chassis_color
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


module chassis_color(
input clock_100mhz,
    input arrow_chassis,
    input [12:0] pixel_index_chassiscolor,
    input [15:0] chassis_color,
    output reg [15:0] oled_data_chassiscolor
    );
    
   //coordinates
    wire [6:0]x;
    wire [5:0]y;
    assign x = (pixel_index_chassiscolor%96);
    assign y = (pixel_index_chassiscolor/96);  
    
        //colors 
    localparam green = 16'b0000010000100000;
    localparam blue = 16'b0000010000111111;
    localparam purple = 16'b1101100011111011; 
    localparam RED = 16'd63488;
    localparam BLACK = 16'd0;
    localparam WHITE = 16'b1111111111111111;
    localparam arrow_color = 16'b1110110011100011;
    wire CHASSIS; wire CONFIRM; wire arrow_CONFIRM; wire GREEN; wire BLUE; wire PURPLE; 
    
    assign CHASSIS =( (x>=16 & x<=17 & y>=2 & y<=4)| (x>=18 & x<=22 & y>=0 & y<=1) |(x>=18 & x<=22 & y>=5 & y<=6)//C
     | (x>=24 & x<=25 & y>=0 & y<=6) | (x>=29 & x<=30 & y>=0 & y<=6) | ( x>=26 & x<=28 & y==3) //H
     | (x>=32 & x<=33 & y>=1 & y<=6) | (x>=37 & x<=38 & y>=1 & y<=6) | (x>=34 & x<=36 & y==4) | (x>=34 & x<=36 & y>=0 & y<=1) //A
     | (x>=41 & x<= 46 & y>=0 & y<=1) | (x>=40 & x<=45 & y>=5 & y<=6) | (x==40 & y==2) | (x==46 & y==4) | (x>=41 & x<=45 & y==3) //S
     | (x>=49 & x<= 54 & y>=0 & y<=1) | (x>=48 & x<=53 & y>=5 & y<=6) | (x==48 & y==2) | (x==54 & y==4) | (x>=49 & x<=53 & y==3) //S
     | (x>=56 & x<=62 & y>=0 & y<=1) | (x>=56 & x<=62 & y>=5 & y<=6)  | (x==59 & y>=2 & y<=4) //I
     | (x>=65 & x<= 70 & y>=0 & y<=1) | (x>=64 & x<=69 & y>=5 & y<=6) | (x==64 & y==2) | (x==70 & y==4) | (x>=65 & x<=69 & y==3) //S
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
    
    always @(posedge clock_100mhz) begin
        if (CHASSIS) begin
            oled_data_chassiscolor <= RED;
        end else if (CONFIRM) begin
            oled_data_chassiscolor <=WHITE;
        end else if (arrow_CONFIRM && arrow_chassis) begin
            oled_data_chassiscolor <= arrow_color;
        end else if (GREEN && (chassis_color==16'd2016)) begin
            oled_data_chassiscolor <=green;
        end else if (BLUE && (chassis_color==16'd31)) begin
            oled_data_chassiscolor <=blue;
        end else begin 
            oled_data_chassiscolor <=BLACK;
            end
        end
endmodule
