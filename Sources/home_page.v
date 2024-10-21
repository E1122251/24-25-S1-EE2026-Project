`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 06:44:36 PM
// Design Name: 
// Module Name: home_page
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


module home_page(
input clock_100mhz,
    input btnC, btnU, btnD, 
    input [12:0] pixel_index_home,
    output reg [15:0] oled_data_home,
    input  wire [2:0] home_state,
    output reg [2:0] home_stateout = 3'b000

    );
            

wire clock_25mhz;
flexi_clockdivider  clock_25mhz_gen( .clock_100mhz(clock_100mhz), .m(32'd1), .clock_output(clock_25mhz) );

     //coordinates
     wire [6:0]x;
     wire [5:0]y;
     assign x = (pixel_index_home%96);
     assign y = (pixel_index_home/96);  
     
     localparam RED = 16'd63488;
     localparam BLACK = 16'd0;
     localparam WHITE = 16'b1111111111111111;
     localparam arrow_color = 16'b1110110011100011;
     
  wire arrow_START; wire arrow_COLOR; wire START; wire COLOR; wire DRIFT_KART;
    
       assign DRIFT_KART = ((x>=8 & x<=9 & y>=0 & y<=6) | (x>=10 & x<=12 & y>=0 & y<=1)| (x>=10 & x<=12 & y>=5 & y<=6)| (x>=13 & x<=14 & y>=2 & y<=4) //D
       | (x>=16 & x<=17 & y>=0 & y<=6)|(x>=18 & x<=21 & y>=0 & y<=1)|(x>=18 & x<=21 & y>=3 & y<=4) |(x==22 & y==2) | (x==21 & y==5) | (x==22 & y==6) //R
       | (x>=24 & x<=30 & y>=0 & y<=1)|(x>=24 & x<=30 & y>=5 & y<=6)|(x>=26 &x<=28 & y>=2 & y<=4) //I
       | (x>=32 & x<=33 & y>=0 & y<=6) |(x>=34 & x<=38 & y>=0 & y<=1)| (x>=34 & x<=36 & y>=3 & y<=4)//F
       | (x>=40 & x<=46 & y>=0 & y<=1) |(x>=42 & x<=44 & y>=0 & y<=6) //T
       | (x>=56 &x<=57 & y>=0 & y<=6) | (x>=58 & x<=59 & y==3) |(x==60 & y==2)|(x==60 & y==4)|(x==61 & y==1)|(x==61 & y==5)|(x==62 & y==0)|(x==62 & y==6) //K
       | (x>=64 & x<=65 & y>=1 & y<=6)|(x>=69 & x<=70 & y>=1 & y<=6)|(x>=66 & x<=68 & y>=0 & y<=1)|(x>=66 & x<=68 & y>=4 & y<=5) //A
       | (x>=72 & x<=73& y>=0 & y<=6)|(x>=74 & x<=77 & y>=0 & y<=1)|(x>=74 & x<=77 & y>=3 & y<=4) |(x==78 & y==2) | (x==77 & y==5) | (x==78 & y==6) //R
       | (x>=80 & x<=86 & y>=0 & y<=1) |(x>=82 & x<=84 & y>=0 & y<=6) //T
       );
       
       assign START = ((x>=25 & x<=30 & y>= 40 & y <=41) | (x==24 & y==42) | (x>=25 & x<=29 & y==43) | (x==30 & y==44) | (x>=24& x<=29 & y>=45 & y<=46) //S
       | (x>=32 & x<=38 & y>= 40 & y <=41) | (x>=34 & x<=36 & y>=40 & y<=46) //T
       |( x>=42 & x<=44 & y==40) | (x>=40 & x<=41 & y>=41 & y<=46) | (x>=45 & x<=46 & y>=41 & y<=46) | (x>=42 & x<=44 & y>=43 & y<=44) //A
       |(x>=48 & x<=49 & y>=40 & y<=46)|(x>=50 & x<=53 & y>=40 & y<=41)|(x>=50 & x<=53 & y>=43 & y<=44) |(x==54 & y==42) | (x==54 & y==46) | (x==53 & y==45) //R
       | (x>=56 & x<=62 & y>= 40 & y <=41) | (x>=58 & x<=60 & y>=40 & y<=46) //T
       );
       
       assign COLOR = ((x>=26 & x<=30 & y>=48 & y<=49) |(x>=26 & x<=30 & y>=53 & y<=54)|(x>=24 & x<=25 & y>=50 & y<=52) //C
       |(x>=33 & x<=37 & y>=48 & y<=49)|(x>=33 & x<=37 & y>=53 & y<=54)| (x>=32 & x<=33 & y>=49 & y<=53)|(x>=37 & x<=38 & y>=49 & y<=53) //O
       |(x>=40 & x<=41 & y>=48 & y<=54)|(x>=40 & x<=46 & y>=53 & y<=54) //L
       |(x>=49 & x<=53 & y>=48 & y<=49)|(x>=49 & x<=53 & y>=53 & y<=54)| (x>=48 & x<=49 & y>=49 & y<=53)|(x>=53 & x<=54 & y>=49 & y<=53) //O
       |(x>=56 & x<=57 & y>=48 & y<=54)|(x>=56 & x<=61 & y>=48 & y<=49)|(x>=56 & x<=61 & y>=51 & y<=52)| (x==62 & y==50)|(x==62 & y==54)|(x==61 & y==53)//R
       );
       
       assign arrow_START = ((x==18 &  y>=40 & y<=46) | (x==19 &  y>=41 & y<=45)| (x==20 & y>=42& y<=44)| (x==21 & y==43));
       assign arrow_COLOR = ((x==18 &  y>=48 & y<=54) | (x==19 &  y>=49 & y<=53)| (x==20 & y>=50 & y<=52)| (x==21 & y==51));
        
        
     //moving arrows up and down
reg selected_arrow_home;
     reg btnU_pressed=0;
     reg btnD_pressed=0;
wire [1:0]btn = {btnU,btnD};
reg btn_pressed;
 
always @(posedge clock_100mhz) begin
if (home_state==3'b000) begin
         if (btnD) begin  
         btnD_pressed <= 1'b1;
 end else btnD_pressed<= btnD_pressed;
 
 if (btnD_pressed) begin 
        selected_arrow_home <=arrow_COLOR;
        end 

if (btnU) begin  
         btnU_pressed <= 1'b1;
 end else btnU_pressed<= btnU_pressed;
 
 if (btnU_pressed) begin 
        selected_arrow_home <=arrow_START;  
        end
if (btnU_pressed & btnD_pressed) begin
    btnU_pressed<=0;
    btnD_pressed<=0;
    end
 
 else begin 
    selected_arrow_home<= (btnD_pressed) ? arrow_COLOR : arrow_START;
    if (btnD_pressed) begin
        home_stateout<=3'b010; //for color
    end else if (!btnD_pressed) begin
        home_stateout<=3'b001; //for start 
    end
end
end  
end


//colors
     always @(posedge clock_100mhz) begin
if (home_state==3'b000) begin
        if (DRIFT_KART) begin
            oled_data_home <=RED;
            end
        else if (START) begin
            oled_data_home  <= WHITE;
            end
        else if (COLOR) begin
                oled_data_home <= WHITE;
                end  
        else if (selected_arrow_home) begin
                        oled_data_home <= arrow_color;
                        end       
        else begin
            oled_data_home  <= BLACK;
end
end
end
            endmodule 