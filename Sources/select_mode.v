`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 06:43:52 PM
// Design Name: 
// Module Name: select_mode
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


module select_mode(
input clock_100mhz,
    input  btnU, btnD,
    input [12:0] pixel_index_select,
    output reg [15:0] oled_data_select,
    input wire [2:0] home_stateout,
    output reg [2:0] select_stateout = 3'b000
    );

wire clock_25mhz;
flexi_clockdivider  clock_25mhz_gen( .clock_100mhz(clock_100mhz), .m(32'd1), .clock_output(clock_25mhz) );

     //coordinates
     wire [6:0]x;
     wire [5:0]y;
     assign x = (pixel_index_select%96);
     assign y = (pixel_index_select/96);  
     
     localparam RED = 16'd63488;
     localparam BLACK = 16'd0;
     localparam WHITE = 16'b1111111111111111;
     localparam arrow_color = 16'b1110110011100011;
     
     wire MODE;  wire STAGE;  wire ENDLESS; wire arrow_STAGE; wire arrow_ENDLESS;
        assign MODE = (((x>=32 & x<=33 & y>=0 & y<=6) | (x>=37 & x<=38 & y>=0 & y<=6) | (x==34 & y >= 1 & y<=2) | (x==36 & y>=1 & y<=2) | (x==35 & y>=2 & y<=3)) //M
        | ((x>=40 & x<=41 & y>=1 & y<=5) | (x>=45 &x<=46 & y>=1 & y<=5) | (x>=41 & x<=45 & y>=0 & y<=1) | ( x>=41 & x<=45 & y>=5 & y<=6)) //O
        | ((x>=48 & x<=49 & y>=0 & y<=6) | (x>=50 & x<=53 & y>=0 & y<=1) | (x>=50 & x<=53 & y>=5 & y <=6) |(x>=53 & x<=54 & y>=1 & y<=5)) //D
        | ((x>=56 & x<=57 & y>=0 & y <=6) | (x>=58 & x<=61 & y>=0 & y<=1) | (x>=58 & x<=61 & y>=5 & y<=6) | (x>=58 & x<=61 & y==3)) //E
        );
        
        assign STAGE = ((x>=25 & x<=30 & y>= 40 & y <=41) | (x==24 & y==42) | (x>=25 & x<=29 & y==43) | (x==30 & y==44) | (x>=24& x<=29 & y>=45 & y<=46) //S
        | (x>=32 & x<=38 & y>= 40 & y <=41) | (x>=34 & x<=36 & y>=40 & y<=46) //T
        |( x>=42 & x<=44 & y==40) | (x>=40 & x<=41 & y>=41 & y<=46) | (x>=45 & x<=46 & y>=41 & y<=46) | (x>=42 & x<=44 & y>=43 & y<=44) //A
        | (x==48 & y>=42 & y<=44) | (x>=49 & x<=54 & y>=40 & y<=41) |(x>=49 & x<=54 & y>=45 & y<=46) | (x==54 & y==44) | (x>=51 & x<=54 & y==43) //G
        | (x>=56 & x<=57 & y>=40 & y<=46) | (x>=56 & x<=62 & y>=40 & y<=41) | (x>=56 & x<=62 & y>=45 & y<=46) | (x>=58 & x<=60 & y==43) //E
        );
        
        assign ENDLESS = ((x>=24 & x<=30 & y>=48 & y<=49) | (x>=24 & x<=30 & y>=53 & y<=54)|(x>=24 & x<=25 & y>=48 & y<=54)|(x>=24 & x<=28 & y==51) //E
        | (x>=32 & x<=33 & y>=48 & y<=54) |(x>=37 & x<=38 &  y>=48 & y<=54)| (x==34 & y>=49 & y<=50) | (x==35 & y>=50 & y<=51) | (x==36 & y>=51 & y<=52) //N
        | (x>=40 & x<=41 &  y>=48 & y<=54)| (x>=42 & x<=44 &y>=48 & y<=49)|(x>=42 & x<=44 & y>=53 & y<=54)| (x>=45 & x<=46 & y>=50 & y<=52) //D
        | (x>=48 & x<=49 &  y>=48 & y<=54)| (x>=48 & x<=54 & y>=53 & y<=54) //L
        | (x>=56 & x<=62 &  y>=48 & y<=49) | (x>=56 & x<=62 & y>=53 & y<=54)|(x>=56 & x<=57 & y>=48 & y<=54)|(x>=58 & x<=60 & y==51) //E
        | (x>=65 & x<=70 & y>=48 & y<=49) | (x==64 & y==50) | (x>=65 & x<=69 & y==51) | (x==70 & y==52) |(x>=64 & x<=69 & y>=53 & y<=54) //S
        | (x>=73 & x<=78 & y>=48 & y<=49) | (x==72 & y==50) | (x>=73 & x<=77 & y==51) | (x==78 & y==52) |(x>=72 & x<=77 & y>=53 & y<=54) //S
        );
       
       assign arrow_STAGE = ((x==18 &  y>=40 & y<=46) | (x==19 &  y>=41 & y<=45)| (x==20 & y>=42& y<=44)| (x==21 & y==43));
       assign arrow_ENDLESS = ((x==18 &  y>=48 & y<=54) | (x==19 &  y>=49 & y<=53)| (x==20 & y>=50 & y<=52)| (x==21 & y==51));
        
        
     //moving arrows up and down
reg selected_arrow_mode;
     reg btnU_pressed_select=0;
     reg btnD_pressed_select=0;
wire [1:0]btn = {btnU,btnD};
reg btn_pressed;
 
always @(posedge clock_100mhz) begin
if (home_stateout==3'b001) begin
         if (btnD) begin  
          btnD_pressed_select <= 1'b1;
 end else  btnD_pressed_select<=  btnD_pressed_select;
 
 if ( btnD_pressed_select) begin 
        selected_arrow_mode <=arrow_STAGE;
        end 

if (btnU) begin  
         btnU_pressed_select <= 1'b1;
 end else btnU_pressed_select<= btnU_pressed_select;
 
 if (btnU_pressed_select) begin 
        selected_arrow_mode <=arrow_ENDLESS;  
        end
if (btnU_pressed_select &  btnD_pressed_select) begin
    btnU_pressed_select<=0;
    btnD_pressed_select<=0;
    end
 
 else begin 
    selected_arrow_mode<= ( btnD_pressed_select) ? arrow_ENDLESS : arrow_STAGE;
        if ( btnD_pressed_select) begin
        select_stateout<=3'b100; //for endless
    end else if (!btnD_pressed_select) begin
        select_stateout<=3'b011; //for stage
    end
    end
end  
end

//colors
     always @(posedge clock_100mhz) begin
if (home_stateout==3'b001) begin
        if (MODE) begin
            oled_data_select <=RED;
            end
        else if (STAGE) begin
            oled_data_select <= WHITE;
            end
        else if (ENDLESS) begin
                oled_data_select <= WHITE;
                end  
        else if (selected_arrow_mode) begin
                        oled_data_select<= arrow_color;
                        end       

        else begin
            oled_data_select <= BLACK;
            end
            end
            end
        

endmodule
