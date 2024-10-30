`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2024 03:32:03 PM
// Design Name: 
// Module Name: car_color
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


module car_color(
    input clock_100mhz, 
    input [1:0] arrow_carcolor,
    input [12:0] pixel_index_car,
    output reg [15:0] oled_data_carcolor
    );

     //coordinates
     wire [6:0]x;
     wire [5:0]y;
     assign x = (pixel_index_car%96);
     assign y = (pixel_index_car/96); 
     
     //color
     localparam RED = 16'd63488;
     localparam BLACK = 16'd0;
     localparam WHITE = 16'b1111111111111111;    
     localparam arrow_color = 16'b1110110011100011;
    
    
    wire COLOR; wire CHASSIS; wire WHEELS; wire CONFIRM;
    
    assign COLOR = ((x>=26 & x<=30 & y>=0 & y<=1)| (x>=26 & x<=30 & y>=5 & y<=6)|(x>=24 & x<=25 & y>=2 & y<=4) //C
    | (x>=32 & x<=33 & y>=1 & y<=5) | (x>=37 & x<=38 & y>=1 & y<=5) |(x>=33 & x<=37 & y>=0 & y<=1) |(x>=33 & x<=37 & y>=5 & y<=6)//O
    | (x>=40 & x<=41 & y>=0 & y<=6) | (x>=42 & x<=46 & y>=5 & y<=6) //L
    | (x>=48 & x<=49 & y>=1 & y<=5) | (x>=53 & x<=54 & y>=1 & y<=5) |(x>=49 & x<=53 & y>=0 & y<=1) |(x>=49 & x<=53 & y>=5 & y<=6)//O
    | (x>=56 & x<=57 & y>=0 & y<=6) | (x>=58 & x<=61 & y>=0 & y<=1) | (x>=58 & x<=61 & y>=3 & y<=4) | (x==62 & y==2) |(x==62 & y==6) |(x==61 & y==5) //R 
    );
    
    assign CHASSIS  = ((x>=26 & x<=30 & y>=40 & y<=41)| (x>=26 & x<=30 & y>=45 & y<=46)|(x>=24 & x<=25 & y>=42 & y<=44) //C
    | (x>=32 & x<=33 & y>=40 & y<=46) | (x>=37 & x<=38 & y>=40 & y<=46) |( x>=34 & x<=36 & y ==43) //H
    | (x>=40 & x<=41 & y>=41 & y<=46) | (x>=45 & x<=46 & y>=41 & y<=46) | (x>=42 & x<=44 & y>=40 & y<=41)| (x>=42 & x<=44 & y==44) //A 
    | (x>=49 & x<=54 & y>=40 & y<=41) | (x>=48 & x<=53 & y>=45 & y<=46) |(x==48 & y==42) | (x==54 & y==44) | (x>=49 & x<=53 & y==43) //S
    | (x>=57 & x<=62 & y>=40 & y<=41) | (x>=56 & x<=61 & y>=45 & y<=46) |(x==56 & y==42) | (x==62 & y==44) | (x>=57 & x<=61 & y==43) //S
    | (x>=64 & x<=70 & y>=40 & y<=41) | (x>=64 & x<=70 & y>=45 & y<=46) | (x==67 & y>=42 & y<=44) //I 
    | (x>=73 & x<=78 & y>=40 & y<=41) | (x>=72 & x<=77 & y>=45 & y<=46) |(x==72 & y==42) | (x==78 & y==44) | (x>=73 & x<=77 & y==43) //S 
    );
    
    assign WHEELS = ((x>=24 & x<=25 & y>=48 & y<=54) | (x>=29 & x<=30 & y>=48 & y<=54) | (x==26 & y>=52 & y<=53) | (x==27 & y>=51 & y<=52) | (x==28 & y>=52 & y<=53) //W
    | (x>=32 & x<=33 & y>=48 & y<=54) | (x>=37 & x<=38 & y>=48 & y<=54) |( x>=34 & x<=36 & y ==51) //H
    | (x>=40 & x<=41 & y>=48 & y<=54) | (x>=40 & x<=46 & y>=48 & y<=49)|(x>=40 & x<=46 & y>=53 & y<=54) | (x>= 42 & x<=44 & y==51)//E
    | (x>=48 & x<=49 & y>=48 & y<=54) | (x>=48 & x<=54 & y>=48 & y<=49)|(x>=48 & x<=54 & y>=53 & y<=54) | (x>= 50 & x<=52 & y==51)//E
    | (x>=56 & x<=57 & y>=48 & y<=54) | (x>=58 & x<=62 & y>=53 & y<=54) //L
    |(x>=65 & x<=70 & y>=48 & y<=49) | (x>=64 & x<=69 & y>=53 & y<=54) |(x==62 & y==50) | (x==70 & y==52) | (x>=65 & x<=69 & y==51) //S 
    );
    
    assign CONFIRM = ((x>=26 & x<=30 & y>=56 & y<=57)| (x>=26 & x<=30 & y>=61 & y<=62)|(x>=24 & x<=25 & y>=58 & y<=60) //C
    | (x>=32 & x<=33 & y>=57 & y<=61) | (x>=37 & x<=38 & y>=57 & y<=61) |(x>=33 & x<=37 & y>=56 & y<=57) |(x>=33 & x<=37 & y>=61 & y<=62)//O
    | (x>=40 & x<=41 & y>=56 & y<=62) | (x>=45 & x<=46 & y>=56 & y<=62) |(x== 42 & y>=57 & y<=58) | (x==43 & y>=58 & y<=59) | (x==44 & y>=59 & y<=60) //N 
    | (x>=48 & x<=49 & y>56 & y<=62) | (x>=48 & x<=54 & y>=56 & y<=57)|(y==59 & x>=49 & x<=52) //F
    |(x>=56 & x<=62 & y>=56 & y<=57)| (x>=56 & x<=62 & y>=61 & y<=62) | (y>=58 & y<=60 & x==59) //I
    | (x>=64 & x<=65 & y>=56 & y<=62) | (x>=66 & x<=70 & y>=56 & y<=57) | (x>=66 & x<=70 & y>=59 & y<=60) | (x==70 & y==58) |(x==70 & y==62) |(x==69 & y==61) //R
    |  (x>=72 & x<=73 & y>=56 & y<=62) | (x>=77 & x<=78 & y>=56 & y<=62) | (x==74 & y>=57 & y<=58) |(x==75 & y>=58 & y<=59) | (x==76 & y>=57 & y<=58)//M
    );
    wire arrow_CHASSIS; wire arrow_WHEELS; wire arrow_CONFIRM;
        
    assign arrow_CHASSIS = ((x==17 & y>=40 & y<=46) | (x==18 & y>=41 & y<=45) | (x==19 & y>=42 & y<=44) | (x==20 & y==43));
    assign arrow_WHEELS = ((x==17 & y>=48 & y<=54) | (x==18 & y>=49 & y<=53) | (x==19 & y>=50 & y<=52) | (x==20 & y==51));
    assign arrow_CONFIRM = ((x==17 & y>=56 & y<=62) | (x==18 & y>=57 & y<=61) | (x==19 & y>=58 & y<=60) | (x==20 & y==59)); 
    
    
    always @(posedge clock_100mhz) begin
                 if (COLOR) begin
                oled_data_carcolor <=RED;
             end else if (CONFIRM) begin
                oled_data_carcolor <=WHITE;
             end else if (CHASSIS) begin
                oled_data_carcolor <=WHITE;
             end else if (WHEELS) begin
                oled_data_carcolor <=WHITE;
             end else if ( ( arrow_carcolor == 2'b01 ) && ( arrow_CHASSIS ) ) begin
                oled_data_carcolor <=arrow_color;
             end else if ( ( arrow_carcolor == 2'b10 ) && ( arrow_WHEELS ) ) begin
                   oled_data_carcolor <=arrow_color;
             end else if ( ( arrow_carcolor == 2'b11 ) && ( arrow_CONFIRM ) ) begin
                      oled_data_carcolor <=arrow_color;
             end else begin
                oled_data_carcolor<=BLACK;
                end
                end

            
endmodule
