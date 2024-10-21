`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2024 11:52:25 AM
// Design Name: 
// Module Name: stage_select_difficulty
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


module stage_select_difficulty(
input clock_100mhz,
    input btnU, btnD, 
    input [12:0] pixel_index_stagediff,
    output reg [15:0] oled_data_stagediff,
    input wire [2:0] select_stateout,
    output reg [2:0] stage_diff_stateout = 3'b000

    );


wire clock_6p25mhz;
wire clock_25mhz;
flexi_clockdivider clock_6p25mhz_gen( .clock_100mhz(clock_100mhz), .m(32'd7), .clock_output(clock_6p25mhz));
flexi_clockdivider  clock_25mhz_gen( .clock_100mhz(clock_100mhz), .m(32'd1), .clock_output(clock_25mhz) );

     //coordinates
     wire [6:0]x;
     wire [5:0]y;
     assign x = (pixel_index_stagediff%96);
     assign y = (pixel_index_stagediff/96);  
     
     localparam RED = 16'd63488;
     localparam BLACK = 16'd0;
     localparam WHITE = 16'b1111111111111111;
     localparam arrow_color = 16'b1110110011100011;
     
     wire STAGE; wire EASY; wire HARD;
             assign STAGE = ((x>=33 & x<=38 & y>= 0 & y <=1) | (x==32 & y==2) | (x>=33 & x<=37 & y==3) | (x==38 & y==4) | (x>=32& x<=37 & y>=5 & y<=6) //S
     | (x>=40 & x<=46 & y>= 0 & y <=1) | (x>=42 & x<=44 & y>=0 & y<=6) //T
     |( x>=50 & x<=52 & y>=0 & y<=1) | (x>=48 & x<=49 & y>=1 & y<=6) | (x>=53 & x<=54 & y>=1 & y<=6) | (x>=50 & x<=52 & y==4) //A
     | (x==56 & y>=2 & y<=4) | (x>=57 & x<=62 & y>=0 & y<=1) |(x>=57 & x<=62 & y>=5 & y<=6) | (x==62 & y==4) | (x>=59 & x<=61 & y==3) //G
     | (x>=64 & x<=65 & y>=0 & y<=6) | (x>=66 & x<=70 & y>=0 & y<=1) | (x>=66 & x<=70 & y>=5 & y<=6) | (x>=66 & x<=68 & y==3) //E
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
 
     //moving arrows up and down
reg selected_arrow_stagediff;
     reg btnU_pressed=0;
     reg btnD_pressed=0;
wire [1:0]btn = {btnU,btnD};
reg btn_pressed;
 
always @(posedge clock_100mhz) begin
if (select_stateout==3'b011) begin
         if (btnD) begin  
         btnD_pressed <= 1'b1;
 end else btnD_pressed<= btnD_pressed;
 
 if (btnD_pressed) begin 
        selected_arrow_stagediff <=arrow_HARD;
        end 

if (btnU) begin  
         btnU_pressed <= 1'b1;
 end else btnU_pressed<= btnU_pressed;
 
 if (btnU_pressed) begin 
        selected_arrow_stagediff<=arrow_EASY;  
        end
if (btnU_pressed & btnD_pressed) begin
    btnU_pressed<=0;
    btnD_pressed<=0;
    end
 
 else begin 
    selected_arrow_stagediff<= (btnD_pressed) ? arrow_HARD : arrow_EASY;
    if (btnD_pressed) begin
        stage_diff_stateout<=3'b101; //HARD
    end else if (!btnD_pressed) begin
         stage_diff_stateout<=3'b110; //EASY
    end
end
end  
end 
     //colors
          always @(posedge clock_100mhz) begin
if (select_stateout==3'b011) begin
             if (STAGE) begin
                 oled_data_stagediff<=RED;
                 end
             else if (EASY) begin
                 oled_data_stagediff<= WHITE;
                 end
             else if (HARD) begin
                     oled_data_stagediff<= WHITE;
                     end  
         //    else if (selected_arrow_mode) begin
         else if (selected_arrow_stagediff) begin
            oled_data_stagediff<= arrow_color;
            end       
     
             else begin
                 oled_data_stagediff <= BLACK;
                 end
                 end
                 end   
endmodule
