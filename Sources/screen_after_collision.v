`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2024 06:09:59 PM
// Design Name: 
// Module Name: screen_after_collision
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


module screen_after_collision(
    input clock_100mhz,
    input [12:0] pixel_index,
    input game_active,
    input is_collision,
    input btnC,
    
    output reg [15:0] oled_data_collision,
    output reg return_to_menu = 0
    );
    
    // hard coded because when I tried to put calculations during animation, it will cause clock cycle to be delayed    
    // car body (45,22) 15x8, last pos (30,17) 58x32  dx = -0.75 dy= 0.25 dw= dh=1.2
    // left headlight (46,24) 4x1, last pos (30,24) 16x7
    // right headlight (56,24) 4x1, last pos (72,24) 4x1
    // car left lowerlight (46,27) 1x1 , last pos (34,36) 6x6
    // car right lowerlight (58,27) 1x1, last pos (78,36) 6x6
    // nametage (51,27) 3x1, last pos (50,36) 18x16
    // window frame (46,19) 13x3, last pos (33,3) 52x14
    // window (47,20) 11x2, last pos (38,8) 42x9
    // left side mirror (44,22) 1x1, last pos (24,17) 6x7
    // right side mirror (60,22) 1x1, last pos (88,17) 6x7
    // car lower black space (47,29) 11x1, last pos(40,44) 38x5
    
    reg [15:0]	  car_body_x_pos =	45 ;
    reg [15:0]    left_headlight_x_pos =    46;
    reg [15:0]    right_headlight_x_pos =    56;
    reg [15:0]    left_lowerlight_x_pos =    46;
    reg [15:0]    right_lowerlight_x_pos =    58;
    reg [15:0]    nametage_x_pos =    51;
    reg [15:0]    window_frame_x_pos =    46;
    reg [15:0]    window_x_pos =    47;
    reg [15:0]    left_side_mirror_x_pos =    44;
    reg [15:0]    right_side_mirror_x_pos =    60;
    reg [15:0]    car_lower_black_space_x_pos =    47;
    
    reg [15:0]	  car_body_y_pos =	22;
    reg [15:0]    left_headlight_y_pos =    24;
    reg [15:0]    right_headlight_y_pos =    24;
    reg [15:0]    left_lowerlight_y_pos =    27;
    reg [15:0]    right_lowerlight_y_pos =    27;
    reg [15:0]    nametage_y_pos =    27;
    reg [15:0]    window_frame_y_pos =    19;
    reg [15:0]    window_y_pos =    20;
    reg [15:0]    left_side_mirror_y_pos =    22;
    reg [15:0]    right_side_mirror_y_pos =    22;
    reg [15:0]    car_lower_black_space_y_pos =    29;
    
    reg [15:0]	  car_body_width =	15;
    reg [15:0]    left_headlight_width =    4;
    reg [15:0]    right_headlight_width =    4;
    reg [15:0]    left_lowerlight_width =    1;
    reg [15:0]    right_lowerlight_width =    1;
    reg [15:0]    nametage_width =    3;
    reg [15:0]    window_frame_width =    13;
    reg [15:0]    window_width =    11;
    reg [15:0]    left_side_mirror_width =    1;
    reg [15:0]    right_side_mirror_width =    1;
    reg [15:0]    car_lower_black_space_width =    11;
    
    reg [15:0]	  car_body_height =	8;
    reg [15:0]    left_headlight_height =    1;
    reg [15:0]    right_headlight_height =    1;
    reg [15:0]    left_lowerlight_height =    1;
    reg [15:0]    right_lowerlight_height =    1;
    reg [15:0]    nametage_height =    1;
    reg [15:0]    window_frame_height =    3;
    reg [15:0]    window_height =    2;
    reg [15:0]    left_side_mirror_height =    1;
    reg [15:0]    right_side_mirror_height =    1;
    reg [15:0]    car_lower_black_space_height =    1;
    
    reg [4:0] frame_counter = 0;
    reg [31:0] frame_clock_counter = 0;
    always @ (posedge clock_100mhz)begin
        if(game_active==1 && is_collision==1) begin
            if (frame_clock_counter == 19_999_999) begin
                frame_clock_counter <= 0;
                if (frame_counter<20)begin
                    frame_counter <= frame_counter+1;
                    end
                end
            else begin
                frame_clock_counter <= frame_clock_counter+1;
                end
        end
        else begin
            frame_counter <= 0;
            frame_clock_counter <=0;     
        end
    end
    
    always @ (*) begin
        case (frame_counter)
        0: begin
        car_body_x_pos <=	44	;
        left_headlight_x_pos <=    45    ;
        right_headlight_x_pos <=    57    ;
        left_lowerlight_x_pos <=    45    ;
        right_lowerlight_x_pos <=    59    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    45    ;
        window_x_pos <=    47    ;
        left_side_mirror_x_pos <=    43    ;
        right_side_mirror_x_pos <=    61    ;
        car_lower_black_space_x_pos <=    47    ;
        //ypos        
        car_body_y_pos <=    22    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    27    ;
        right_lowerlight_y_pos <=    27    ;
        nametage_y_pos <=    27    ;
        window_frame_y_pos <=    18    ;
        window_y_pos <=    19    ;
        left_side_mirror_y_pos <=    22    ;
        right_side_mirror_y_pos <=    22    ;
        car_lower_black_space_y_pos <=    30    ;
        //width        
        car_body_width <=    17    ;
        left_headlight_width <=    5    ;
        right_headlight_width <=    5    ;
        left_lowerlight_width <=    1    ;
        right_lowerlight_width <=    1    ;
        nametage_width <=    4    ;
        window_frame_width <=    15    ;
        window_width <=    13    ;
        left_side_mirror_width <=    1    ;
        right_side_mirror_width <=    1    ;
        car_lower_black_space_width <=    12    ;
        //height        
        car_body_height <=    9    ;
        left_headlight_height <=    1    ;
        right_headlight_height <=    1    ;
        left_lowerlight_height <=    1    ;
        right_lowerlight_height <=    1    ;
        nametage_height <=    2    ;
        window_frame_height <=    4    ;
        window_height <=    2    ;
        left_side_mirror_height <=    1    ;
        right_side_mirror_height <=    1    ;
        car_lower_black_space_height <=    1    ;
        end
        1: begin
        car_body_x_pos <=	44	;
        left_headlight_x_pos <=    44    ;
        right_headlight_x_pos <=    58    ;
        left_lowerlight_x_pos <=    45    ;
        right_lowerlight_x_pos <=    60    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    45    ;
        window_x_pos <=    46    ;
        left_side_mirror_x_pos <=    42    ;
        right_side_mirror_x_pos <=    63    ;
        car_lower_black_space_x_pos <=    46    ;
        //ypos        
        car_body_y_pos <=    22    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    28    ;
        right_lowerlight_y_pos <=    28    ;
        nametage_y_pos <=    28    ;
        window_frame_y_pos <=    17    ;
        window_y_pos <=    19    ;
        left_side_mirror_y_pos <=    22    ;
        right_side_mirror_y_pos <=    22    ;
        car_lower_black_space_y_pos <=    31    ;
        //width        
        car_body_width <=    19    ;
        left_headlight_width <=    5    ;
        right_headlight_width <=    5    ;
        left_lowerlight_width <=    2    ;
        right_lowerlight_width <=    2    ;
        nametage_width <=    5    ;
        window_frame_width <=    17    ;
        window_width <=    14    ;
        left_side_mirror_width <=    2    ;
        right_side_mirror_width <=    2    ;
        car_lower_black_space_width <=    14    ;
        //height        
        car_body_height <=    10    ;
        left_headlight_height <=    2    ;
        right_headlight_height <=    2    ;
        left_lowerlight_height <=    2    ;
        right_lowerlight_height <=    2    ;
        nametage_height <=    3    ;
        window_frame_height <=    4    ;
        window_height <=    3    ;
        left_side_mirror_height <=    2    ;
        right_side_mirror_height <=    2    ;
        car_lower_black_space_height <=    1    ;
        end
        2: begin
        car_body_x_pos <=	43	;
        left_headlight_x_pos <=    44    ;
        right_headlight_x_pos <=    58    ;
        left_lowerlight_x_pos <=    44    ;
        right_lowerlight_x_pos <=    61    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    44    ;
        window_x_pos <=    46    ;
        left_side_mirror_x_pos <=    41    ;
        right_side_mirror_x_pos <=    64    ;
        car_lower_black_space_x_pos <=    46    ;
        //ypos        
        car_body_y_pos <=    21    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    28    ;
        right_lowerlight_y_pos <=    28    ;
        nametage_y_pos <=    28    ;
        window_frame_y_pos <=    17    ;
        window_y_pos <=    18    ;
        left_side_mirror_y_pos <=    21    ;
        right_side_mirror_y_pos <=    21    ;
        car_lower_black_space_y_pos <=    31    ;
        //width        
        car_body_width <=    21    ;
        left_headlight_width <=    6    ;
        right_headlight_width <=    6    ;
        left_lowerlight_width <=    2    ;
        right_lowerlight_width <=    2    ;
        nametage_width <=    5    ;
        window_frame_width <=    19    ;
        window_width <=    16    ;
        left_side_mirror_width <=    2    ;
        right_side_mirror_width <=    2    ;
        car_lower_black_space_width <=    15    ;
        //height        
        car_body_height <=    12    ;
        left_headlight_height <=    2    ;
        right_headlight_height <=    2    ;
        left_lowerlight_height <=    2    ;
        right_lowerlight_height <=    2    ;
        nametage_height <=    3    ;
        window_frame_height <=    5    ;
        window_height <=    3    ;
        left_side_mirror_height <=    2    ;
        right_side_mirror_height <=    2    ;
        car_lower_black_space_height <=    2    ;
        end
        3: begin
        car_body_x_pos <=	43	;
        left_headlight_x_pos <=    44    ;
        right_headlight_x_pos <=    58    ;
        left_lowerlight_x_pos <=    44    ;
        right_lowerlight_x_pos <=    61    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    44    ;
        window_x_pos <=    46    ;
        left_side_mirror_x_pos <=    41    ;
        right_side_mirror_x_pos <=    64    ;
        car_lower_black_space_x_pos <=    46    ;
        //ypos        
        car_body_y_pos <=    21    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    28    ;
        right_lowerlight_y_pos <=    28    ;
        nametage_y_pos <=    28    ;
        window_frame_y_pos <=    17    ;
        window_y_pos <=    18    ;
        left_side_mirror_y_pos <=    21    ;
        right_side_mirror_y_pos <=    21    ;
        car_lower_black_space_y_pos <=    31    ;
        //width        
        car_body_width <=    21    ;
        left_headlight_width <=    6    ;
        right_headlight_width <=    6    ;
        left_lowerlight_width <=    2    ;
        right_lowerlight_width <=    2    ;
        nametage_width <=    5    ;
        window_frame_width <=    19    ;
        window_width <=    16    ;
        left_side_mirror_width <=    2    ;
        right_side_mirror_width <=    2    ;
        car_lower_black_space_width <=    15    ;
        //height        
        car_body_height <=    12    ;
        left_headlight_height <=    2    ;
        right_headlight_height <=    2    ;
        left_lowerlight_height <=    2    ;
        right_lowerlight_height <=    2    ;
        nametage_height <=    3    ;
        window_frame_height <=    5    ;
        window_height <=    3    ;
        left_side_mirror_height <=    2    ;
        right_side_mirror_height <=    2    ;
        car_lower_black_space_height <=    2    ;
        end
        4: begin
        car_body_x_pos <=	42	;
        left_headlight_x_pos <=    43    ;
        right_headlight_x_pos <=    59    ;
        left_lowerlight_x_pos <=    44    ;
        right_lowerlight_x_pos <=    62    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    43    ;
        window_x_pos <=    45    ;
        left_side_mirror_x_pos <=    40    ;
        right_side_mirror_x_pos <=    66    ;
        car_lower_black_space_x_pos <=    46    ;
        //ypos        
        car_body_y_pos <=    21    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    29    ;
        right_lowerlight_y_pos <=    29    ;
        nametage_y_pos <=    29    ;
        window_frame_y_pos <=    16    ;
        window_y_pos <=    18    ;
        left_side_mirror_y_pos <=    21    ;
        right_side_mirror_y_pos <=    21    ;
        car_lower_black_space_y_pos <=    32    ;
        //width        
        car_body_width <=    24    ;
        left_headlight_width <=    6    ;
        right_headlight_width <=    6    ;
        left_lowerlight_width <=    2    ;
        right_lowerlight_width <=    2    ;
        nametage_width <=    6    ;
        window_frame_width <=    21    ;
        window_width <=    17    ;
        left_side_mirror_width <=    2    ;
        right_side_mirror_width <=    2    ;
        car_lower_black_space_width <=    16    ;
        //height        
        car_body_height <=    13    ;
        left_headlight_height <=    2    ;
        right_headlight_height <=    2    ;
        left_lowerlight_height <=    2    ;
        right_lowerlight_height <=    2    ;
        nametage_height <=    4    ;
        window_frame_height <=    5    ;
        window_height <=    3    ;
        left_side_mirror_height <=    2    ;
        right_side_mirror_height <=    2    ;
        car_lower_black_space_height <=    2    ;
        end
        5: begin
        car_body_x_pos <=	41	;
        left_headlight_x_pos <=    42    ;
        right_headlight_x_pos <=    60    ;
        left_lowerlight_x_pos <=    43    ;
        right_lowerlight_x_pos <=    63    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    43    ;
        window_x_pos <=    45    ;
        left_side_mirror_x_pos <=    39    ;
        right_side_mirror_x_pos <=    67    ;
        car_lower_black_space_x_pos <=    45    ;
        //ypos        
        car_body_y_pos <=    21    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    29    ;
        right_lowerlight_y_pos <=    29    ;
        nametage_y_pos <=    29    ;
        window_frame_y_pos <=    15    ;
        window_y_pos <=    17    ;
        left_side_mirror_y_pos <=    21    ;
        right_side_mirror_y_pos <=    21    ;
        car_lower_black_space_y_pos <=    33    ;
        //width        
        car_body_width <=    26    ;
        left_headlight_width <=    7    ;
        right_headlight_width <=    7    ;
        left_lowerlight_width <=    2    ;
        right_lowerlight_width <=    2    ;
        nametage_width <=    7    ;
        window_frame_width <=    23    ;
        window_width <=    19    ;
        left_side_mirror_width <=    2    ;
        right_side_mirror_width <=    2    ;
        car_lower_black_space_width <=    18    ;
        //height        
        car_body_height <=    14    ;
        left_headlight_height <=    3    ;
        right_headlight_height <=    3    ;
        left_lowerlight_height <=    2    ;
        right_lowerlight_height <=    2    ;
        nametage_height <=    5    ;
        window_frame_height <=    6    ;
        window_height <=    4    ;
        left_side_mirror_height <=    3    ;
        right_side_mirror_height <=    3    ;
        car_lower_black_space_height <=    2    ;
        end
        6: begin
        car_body_x_pos <=	41	;
        left_headlight_x_pos <=    41    ;
        right_headlight_x_pos <=    61    ;
        left_lowerlight_x_pos <=    42    ;
        right_lowerlight_x_pos <=    64    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    42    ;
        window_x_pos <=    44    ;
        left_side_mirror_x_pos <=    38    ;
        right_side_mirror_x_pos <=    68    ;
        car_lower_black_space_x_pos <=    45    ;
        //ypos        
        car_body_y_pos <=    21    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    30    ;
        right_lowerlight_y_pos <=    30    ;
        nametage_y_pos <=    30    ;
        window_frame_y_pos <=    14    ;
        window_y_pos <=    16    ;
        left_side_mirror_y_pos <=    21    ;
        right_side_mirror_y_pos <=    21    ;
        car_lower_black_space_y_pos <=    34    ;
        //width        
        car_body_width <=    28    ;
        left_headlight_width <=    8    ;
        right_headlight_width <=    8    ;
        left_lowerlight_width <=    3    ;
        right_lowerlight_width <=    3    ;
        nametage_width <=    8    ;
        window_frame_width <=    25    ;
        window_width <=    20    ;
        left_side_mirror_width <=    3    ;
        right_side_mirror_width <=    3    ;
        car_lower_black_space_width <=    19    ;
        //height        
        car_body_height <=    15    ;
        left_headlight_height <=    3    ;
        right_headlight_height <=    3    ;
        left_lowerlight_height <=    3    ;
        right_lowerlight_height <=    3    ;
        nametage_height <=    6    ;
        window_frame_height <=    6    ;
        window_height <=    4    ;
        left_side_mirror_height <=    3    ;
        right_side_mirror_height <=    3    ;
        car_lower_black_space_height <=    2    ;
        end
        7: begin
        car_body_x_pos <=	40	;
        left_headlight_x_pos <=    40    ;
        right_headlight_x_pos <=    62    ;
        left_lowerlight_x_pos <=    42    ;
        right_lowerlight_x_pos <=    65    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    41    ;
        window_x_pos <=    44    ;
        left_side_mirror_x_pos <=    37    ;
        right_side_mirror_x_pos <=    70    ;
        car_lower_black_space_x_pos <=    45    ;
        //ypos        
        car_body_y_pos <=    20    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    30    ;
        right_lowerlight_y_pos <=    30    ;
        nametage_y_pos <=    30    ;
        window_frame_y_pos <=    13    ;
        window_y_pos <=    16    ;
        left_side_mirror_y_pos <=    20    ;
        right_side_mirror_y_pos <=    20    ;
        car_lower_black_space_y_pos <=    34    ;
        //width        
        car_body_width <=    30    ;
        left_headlight_width <=    8    ;
        right_headlight_width <=    8    ;
        left_lowerlight_width <=    3    ;
        right_lowerlight_width <=    3    ;
        nametage_width <=    8    ;
        window_frame_width <=    27    ;
        window_width <=    22    ;
        left_side_mirror_width <=    3    ;
        right_side_mirror_width <=    3    ;
        car_lower_black_space_width <=    20    ;
        //height        
        car_body_height <=    16    ;
        left_headlight_height <=    3    ;
        right_headlight_height <=    3    ;
        left_lowerlight_height <=    3    ;
        right_lowerlight_height <=    3    ;
        nametage_height <=    6    ;
        window_frame_height <=    7    ;
        window_height <=    4    ;
        left_side_mirror_height <=    3    ;
        right_side_mirror_height <=    3    ;
        car_lower_black_space_height <=    2    ;
        end
        8: begin
        car_body_x_pos <=	39	;
        left_headlight_x_pos <=    40    ;
        right_headlight_x_pos <=    62    ;
        left_lowerlight_x_pos <=    41    ;
        right_lowerlight_x_pos <=    66    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    41    ;
        window_x_pos <=    43    ;
        left_side_mirror_x_pos <=    36    ;
        right_side_mirror_x_pos <=    71    ;
        car_lower_black_space_x_pos <=    44    ;
        //ypos        
        car_body_y_pos <=    20    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    31    ;
        right_lowerlight_y_pos <=    31    ;
        nametage_y_pos <=    31    ;
        window_frame_y_pos <=    13    ;
        window_y_pos <=    15    ;
        left_side_mirror_y_pos <=    20    ;
        right_side_mirror_y_pos <=    20    ;
        car_lower_black_space_y_pos <=    35    ;
        //width        
        car_body_width <=    32    ;
        left_headlight_width <=    9    ;
        right_headlight_width <=    9    ;
        left_lowerlight_width <=    3    ;
        right_lowerlight_width <=    3    ;
        nametage_width <=    9    ;
        window_frame_width <=    29    ;
        window_width <=    23    ;
        left_side_mirror_width <=    3    ;
        right_side_mirror_width <=    3    ;
        car_lower_black_space_width <=    22    ;
        //height        
        car_body_height <=    18    ;
        left_headlight_height <=    3    ;
        right_headlight_height <=    3    ;
        left_lowerlight_height <=    3    ;
        right_lowerlight_height <=    3    ;
        nametage_height <=    7    ;
        window_frame_height <=    7    ;
        window_height <=    5    ;
        left_side_mirror_height <=    3    ;
        right_side_mirror_height <=    3    ;
        car_lower_black_space_height <=    3    ;
        end
        9: begin
        car_body_x_pos <=	38	;
        left_headlight_x_pos <=    39    ;
        right_headlight_x_pos <=    63    ;
        left_lowerlight_x_pos <=    41    ;
        right_lowerlight_x_pos <=    67    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    40    ;
        window_x_pos <=    43    ;
        left_side_mirror_x_pos <=    35    ;
        right_side_mirror_x_pos <=    73    ;
        car_lower_black_space_x_pos <=    44    ;
        //ypos        
        car_body_y_pos <=    20    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    31    ;
        right_lowerlight_y_pos <=    31    ;
        nametage_y_pos <=    31    ;
        window_frame_y_pos <=    12    ;
        window_y_pos <=    15    ;
        left_side_mirror_y_pos <=    20    ;
        right_side_mirror_y_pos <=    20    ;
        car_lower_black_space_y_pos <=    36    ;
        //width        
        car_body_width <=    34    ;
        left_headlight_width <=    9    ;
        right_headlight_width <=    9    ;
        left_lowerlight_width <=    3    ;
        right_lowerlight_width <=    3    ;
        nametage_width <=    10    ;
        window_frame_width <=    31    ;
        window_width <=    25    ;
        left_side_mirror_width <=    3    ;
        right_side_mirror_width <=    3    ;
        car_lower_black_space_width <=    23    ;
        //height        
        car_body_height <=    19    ;
        left_headlight_height <=    4    ;
        right_headlight_height <=    4    ;
        left_lowerlight_height <=    3    ;
        right_lowerlight_height <=    3    ;
        nametage_height <=    8    ;
        window_frame_height <=    8    ;
        window_height <=    5    ;
        left_side_mirror_height <=    4    ;
        right_side_mirror_height <=    4    ;
        car_lower_black_space_height <=    3    ;
        end
        10: begin
        car_body_x_pos <=	38	;
        left_headlight_x_pos <=    38    ;
        right_headlight_x_pos <=    64    ;
        left_lowerlight_x_pos <=    40    ;
        right_lowerlight_x_pos <=    68    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    40    ;
        window_x_pos <=    43    ;
        left_side_mirror_x_pos <=    34    ;
        right_side_mirror_x_pos <=    74    ;
        car_lower_black_space_x_pos <=    44    ;
        //ypos        
        car_body_y_pos <=    20    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    32    ;
        right_lowerlight_y_pos <=    32    ;
        nametage_y_pos <=    32    ;
        window_frame_y_pos <=    11    ;
        window_y_pos <=    14    ;
        left_side_mirror_y_pos <=    20    ;
        right_side_mirror_y_pos <=    20    ;
        car_lower_black_space_y_pos <=    37    ;
        //width        
        car_body_width <=    37    ;
        left_headlight_width <=    10    ;
        right_headlight_width <=    10    ;
        left_lowerlight_width <=    4    ;
        right_lowerlight_width <=    4    ;
        nametage_width <=    11    ;
        window_frame_width <=    33    ;
        window_width <=    27    ;
        left_side_mirror_width <=    4    ;
        right_side_mirror_width <=    4    ;
        car_lower_black_space_width <=    25    ;
        //height        
        car_body_height <=    20    ;
        left_headlight_height <=    4    ;
        right_headlight_height <=    4    ;
        left_lowerlight_height <=    4    ;
        right_lowerlight_height <=    4    ;
        nametage_height <=    9    ;
        window_frame_height <=    9    ;
        window_height <=    6    ;
        left_side_mirror_height <=    4    ;
        right_side_mirror_height <=    4    ;
        car_lower_black_space_height <=    3    ;
        end
        11: begin
        car_body_x_pos <=	37	;
        left_headlight_x_pos <=    37    ;
        right_headlight_x_pos <=    65    ;
        left_lowerlight_x_pos <=    39    ;
        right_lowerlight_x_pos <=    69    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    39    ;
        window_x_pos <=    42    ;
        left_side_mirror_x_pos <=    33    ;
        right_side_mirror_x_pos <=    75    ;
        car_lower_black_space_x_pos <=    43    ;
        //ypos        
        car_body_y_pos <=    19    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    32    ;
        right_lowerlight_y_pos <=    32    ;
        nametage_y_pos <=    32    ;
        window_frame_y_pos <=    10    ;
        window_y_pos <=    13    ;
        left_side_mirror_y_pos <=    19    ;
        right_side_mirror_y_pos <=    19    ;
        car_lower_black_space_y_pos <=    37    ;
        //width        
        car_body_width <=    39    ;
        left_headlight_width <=    11    ;
        right_headlight_width <=    11    ;
        left_lowerlight_width <=    4    ;
        right_lowerlight_width <=    4    ;
        nametage_width <=    11    ;
        window_frame_width <=    34    ;
        window_width <=    28    ;
        left_side_mirror_width <=    4    ;
        right_side_mirror_width <=    4    ;
        car_lower_black_space_width <=    26    ;
        //height        
        car_body_height <=    21    ;
        left_headlight_height <=    4    ;
        right_headlight_height <=    4    ;
        left_lowerlight_height <=    4    ;
        right_lowerlight_height <=    4    ;
        nametage_height <=    9    ;
        window_frame_height <=    9    ;
        window_height <=    6    ;
        left_side_mirror_height <=    4    ;
        right_side_mirror_height <=    4    ;
        car_lower_black_space_height <=    3    ;
        end
        12: begin
        car_body_x_pos <=	36	;
        left_headlight_x_pos <=    36    ;
        right_headlight_x_pos <=    66    ;
        left_lowerlight_x_pos <=    39    ;
        right_lowerlight_x_pos <=    70    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    38    ;
        window_x_pos <=    42    ;
        left_side_mirror_x_pos <=    32    ;
        right_side_mirror_x_pos <=    77    ;
        car_lower_black_space_x_pos <=    43    ;
        //ypos        
        car_body_y_pos <=    19    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    32    ;
        right_lowerlight_y_pos <=    32    ;
        nametage_y_pos <=    32    ;
        window_frame_y_pos <=    9    ;
        window_y_pos <=    13    ;
        left_side_mirror_y_pos <=    19    ;
        right_side_mirror_y_pos <=    19    ;
        car_lower_black_space_y_pos <=    38    ;
        //width        
        car_body_width <=    41    ;
        left_headlight_width <=    11    ;
        right_headlight_width <=    11    ;
        left_lowerlight_width <=    4    ;
        right_lowerlight_width <=    4    ;
        nametage_width <=    12    ;
        window_frame_width <=    36    ;
        window_width <=    30    ;
        left_side_mirror_width <=    4    ;
        right_side_mirror_width <=    4    ;
        car_lower_black_space_width <=    27    ;
        //height        
        car_body_height <=    22    ;
        left_headlight_height <=    5    ;
        right_headlight_height <=    5    ;
        left_lowerlight_height <=    4    ;
        right_lowerlight_height <=    4    ;
        nametage_height <=    10    ;
        window_frame_height <=    10    ;
        window_height <=    6    ;
        left_side_mirror_height <=    5    ;
        right_side_mirror_height <=    5    ;
        car_lower_black_space_height <=    3    ;
        end
        13: begin
        car_body_x_pos <=	35	;
        left_headlight_x_pos <=    36    ;
        right_headlight_x_pos <=    66    ;
        left_lowerlight_x_pos <=    38    ;
        right_lowerlight_x_pos <=    71    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    38    ;
        window_x_pos <=    41    ;
        left_side_mirror_x_pos <=    31    ;
        right_side_mirror_x_pos <=    78    ;
        car_lower_black_space_x_pos <=    42    ;
        //ypos        
        car_body_y_pos <=    19    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    33    ;
        right_lowerlight_y_pos <=    33    ;
        nametage_y_pos <=    33    ;
        window_frame_y_pos <=    9    ;
        window_y_pos <=    12    ;
        left_side_mirror_y_pos <=    19    ;
        right_side_mirror_y_pos <=    19    ;
        car_lower_black_space_y_pos <=    39    ;
        //width        
        car_body_width <=    43    ;
        left_headlight_width <=    12    ;
        right_headlight_width <=    12    ;
        left_lowerlight_width <=    4    ;
        right_lowerlight_width <=    4    ;
        nametage_width <=    13    ;
        window_frame_width <=    38    ;
        window_width <=    31    ;
        left_side_mirror_width <=    4    ;
        right_side_mirror_width <=    4    ;
        car_lower_black_space_width <=    29    ;
        //height        
        car_body_height <=    24    ;
        left_headlight_height <=    5    ;
        right_headlight_height <=    5    ;
        left_lowerlight_height <=    4    ;
        right_lowerlight_height <=    4    ;
        nametage_height <=    11    ;
        window_frame_height <=    10    ;
        window_height <=    7    ;
        left_side_mirror_height <=    5    ;
        right_side_mirror_height <=    5    ;
        car_lower_black_space_height <=    4    ;
        end
        14: begin
        car_body_x_pos <=	35	;
        left_headlight_x_pos <=    35    ;
        right_headlight_x_pos <=    67    ;
        left_lowerlight_x_pos <=    38    ;
        right_lowerlight_x_pos <=    72    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    37    ;
        window_x_pos <=    41    ;
        left_side_mirror_x_pos <=    30    ;
        right_side_mirror_x_pos <=    80    ;
        car_lower_black_space_x_pos <=    42    ;
        //ypos        
        car_body_y_pos <=    19    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    33    ;
        right_lowerlight_y_pos <=    33    ;
        nametage_y_pos <=    33    ;
        window_frame_y_pos <=    8    ;
        window_y_pos <=    12    ;
        left_side_mirror_y_pos <=    19    ;
        right_side_mirror_y_pos <=    19    ;
        car_lower_black_space_y_pos <=    40    ;
        //width        
        car_body_width <=    45    ;
        left_headlight_width <=    12    ;
        right_headlight_width <=    12    ;
        left_lowerlight_width <=    5    ;
        right_lowerlight_width <=    5    ;
        nametage_width <=    14    ;
        window_frame_width <=    40    ;
        window_width <=    33    ;
        left_side_mirror_width <=    5    ;
        right_side_mirror_width <=    5    ;
        car_lower_black_space_width <=    30    ;
        //height        
        car_body_height <=    25    ;
        left_headlight_height <=    5    ;
        right_headlight_height <=    5    ;
        left_lowerlight_height <=    5    ;
        right_lowerlight_height <=    5    ;
        nametage_height <=    12    ;
        window_frame_height <=    11    ;
        window_height <=    7    ;
        left_side_mirror_height <=    5    ;
        right_side_mirror_height <=    5    ;
        car_lower_black_space_height <=    4    ;
        end
        15: begin
        car_body_x_pos <=	34	;
        left_headlight_x_pos <=    34    ;
        right_headlight_x_pos <=    68    ;
        left_lowerlight_x_pos <=    37    ;
        right_lowerlight_x_pos <=    73    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    36    ;
        window_x_pos <=    40    ;
        left_side_mirror_x_pos <=    29    ;
        right_side_mirror_x_pos <=    81    ;
        car_lower_black_space_x_pos <=    42    ;
        //ypos        
        car_body_y_pos <=    18    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    34    ;
        right_lowerlight_y_pos <=    34    ;
        nametage_y_pos <=    34    ;
        window_frame_y_pos <=    7    ;
        window_y_pos <=    11    ;
        left_side_mirror_y_pos <=    18    ;
        right_side_mirror_y_pos <=    18    ;
        car_lower_black_space_y_pos <=    40    ;
        //width        
        car_body_width <=    47    ;
        left_headlight_width <=    13    ;
        right_headlight_width <=    13    ;
        left_lowerlight_width <=    5    ;
        right_lowerlight_width <=    5    ;
        nametage_width <=    14    ;
        window_frame_width <=    42    ;
        window_width <=    34    ;
        left_side_mirror_width <=    5    ;
        right_side_mirror_width <=    5    ;
        car_lower_black_space_width <=    31    ;
        //height        
        car_body_height <=    26    ;
        left_headlight_height <=    6    ;
        right_headlight_height <=    6    ;
        left_lowerlight_height <=    5    ;
        right_lowerlight_height <=    5    ;
        nametage_height <=    12    ;
        window_frame_height <=    11    ;
        window_height <=    7    ;
        left_side_mirror_height <=    6    ;
        right_side_mirror_height <=    6    ;
        car_lower_black_space_height <=    4    ;
        end
        16: begin
        car_body_x_pos <=	33	;
        left_headlight_x_pos <=    33    ;
        right_headlight_x_pos <=    69    ;
        left_lowerlight_x_pos <=    36    ;
        right_lowerlight_x_pos <=    74    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    36    ;
        window_x_pos <=    40    ;
        left_side_mirror_x_pos <=    28    ;
        right_side_mirror_x_pos <=    82    ;
        car_lower_black_space_x_pos <=    41    ;
        //ypos        
        car_body_y_pos <=    18    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    34    ;
        right_lowerlight_y_pos <=    34    ;
        nametage_y_pos <=    34    ;
        window_frame_y_pos <=    6    ;
        window_y_pos <=    10    ;
        left_side_mirror_y_pos <=    18    ;
        right_side_mirror_y_pos <=    18    ;
        car_lower_black_space_y_pos <=    41    ;
        //width        
        car_body_width <=    49    ;
        left_headlight_width <=    14    ;
        right_headlight_width <=    14    ;
        left_lowerlight_width <=    5    ;
        right_lowerlight_width <=    5    ;
        nametage_width <=    15    ;
        window_frame_width <=    44    ;
        window_width <=    36    ;
        left_side_mirror_width <=    5    ;
        right_side_mirror_width <=    5    ;
        car_lower_black_space_width <=    33    ;
        //height        
        car_body_height <=    27    ;
        left_headlight_height <=    6    ;
        right_headlight_height <=    6    ;
        left_lowerlight_height <=    5    ;
        right_lowerlight_height <=    5    ;
        nametage_height <=    13    ;
        window_frame_height <=    12    ;
        window_height <=    8    ;
        left_side_mirror_height <=    6    ;
        right_side_mirror_height <=    6    ;
        car_lower_black_space_height <=    4    ;
        end
        17: begin
        car_body_x_pos <=	32	;
        left_headlight_x_pos <=    32    ;
        right_headlight_x_pos <=    70    ;
        left_lowerlight_x_pos <=    36    ;
        right_lowerlight_x_pos <=    75    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    35    ;
        window_x_pos <=    39    ;
        left_side_mirror_x_pos <=    27    ;
        right_side_mirror_x_pos <=    84    ;
        car_lower_black_space_x_pos <=    41    ;
        //ypos        
        car_body_y_pos <=    18    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    35    ;
        right_lowerlight_y_pos <=    35    ;
        nametage_y_pos <=    35    ;
        window_frame_y_pos <=    5    ;
        window_y_pos <=    10    ;
        left_side_mirror_y_pos <=    18    ;
        right_side_mirror_y_pos <=    18    ;
        car_lower_black_space_y_pos <=    42    ;
        //width        
        car_body_width <=    52    ;
        left_headlight_width <=    14    ;
        right_headlight_width <=    14    ;
        left_lowerlight_width <=    5    ;
        right_lowerlight_width <=    5    ;
        nametage_width <=    16    ;
        window_frame_width <=    46    ;
        window_width <=    37    ;
        left_side_mirror_width <=    5    ;
        right_side_mirror_width <=    5    ;
        car_lower_black_space_width <=    34    ;
        //height        
        car_body_height <=    28    ;
        left_headlight_height <=    6    ;
        right_headlight_height <=    6    ;
        left_lowerlight_height <=    5    ;
        right_lowerlight_height <=    5    ;
        nametage_height <=    14    ;
        window_frame_height <=    12    ;
        window_height <=    8    ;
        left_side_mirror_height <=    6    ;
        right_side_mirror_height <=    6    ;
        car_lower_black_space_height <=    4    ;
        end
        18: begin
        car_body_x_pos <=	32	;
        left_headlight_x_pos <=    32    ;
        right_headlight_x_pos <=    70    ;
        left_lowerlight_x_pos <=    35    ;
        right_lowerlight_x_pos <=    76    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    34    ;
        window_x_pos <=    39    ;
        left_side_mirror_x_pos <=    26    ;
        right_side_mirror_x_pos <=    85    ;
        car_lower_black_space_x_pos <=    41    ;
        //ypos        
        car_body_y_pos <=    18    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    35    ;
        right_lowerlight_y_pos <=    35    ;
        nametage_y_pos <=    35    ;
        window_frame_y_pos <=    5    ;
        window_y_pos <=    9    ;
        left_side_mirror_y_pos <=    18    ;
        right_side_mirror_y_pos <=    18    ;
        car_lower_black_space_y_pos <=    43    ;
        //width        
        car_body_width <=    54    ;
        left_headlight_width <=    15    ;
        right_headlight_width <=    15    ;
        left_lowerlight_width <=    6    ;
        right_lowerlight_width <=    6    ;
        nametage_width <=    17    ;
        window_frame_width <=    48    ;
        window_width <=    39    ;
        left_side_mirror_width <=    6    ;
        right_side_mirror_width <=    6    ;
        car_lower_black_space_width <=    35    ;
        //height        
        car_body_height <=    30    ;
        left_headlight_height <=    6    ;
        right_headlight_height <=    6    ;
        left_lowerlight_height <=    6    ;
        right_lowerlight_height <=    6    ;
        nametage_height <=    15    ;
        window_frame_height <=    13    ;
        window_height <=    8    ;
        left_side_mirror_height <=    6    ;
        right_side_mirror_height <=    6    ;
        car_lower_black_space_height <=    5    ;
        end
        19: begin
        car_body_x_pos <=	31	;
        left_headlight_x_pos <=    31    ;
        right_headlight_x_pos <=    71    ;
        left_lowerlight_x_pos <=    35    ;
        right_lowerlight_x_pos <=    77    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    34    ;
        window_x_pos <=    38    ;
        left_side_mirror_x_pos <=    25    ;
        right_side_mirror_x_pos <=    87    ;
        car_lower_black_space_x_pos <=    40    ;
        //ypos        
        car_body_y_pos <=    17    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    36    ;
        right_lowerlight_y_pos <=    36    ;
        nametage_y_pos <=    36    ;
        window_frame_y_pos <=    4    ;
        window_y_pos <=    9    ;
        left_side_mirror_y_pos <=    17    ;
        right_side_mirror_y_pos <=    17    ;
        car_lower_black_space_y_pos <=    43    ;
        //width        
        car_body_width <=    56    ;
        left_headlight_width <=    15    ;
        right_headlight_width <=    15    ;
        left_lowerlight_width <=    6    ;
        right_lowerlight_width <=    6    ;
        nametage_width <=    17    ;
        window_frame_width <=    50    ;
        window_width <=    40    ;
        left_side_mirror_width <=    6    ;
        right_side_mirror_width <=    6    ;
        car_lower_black_space_width <=    37    ;
        //height        
        car_body_height <=    31    ;
        left_headlight_height <=    7    ;
        right_headlight_height <=    7    ;
        left_lowerlight_height <=    6    ;
        right_lowerlight_height <=    6    ;
        nametage_height <=    15    ;
        window_frame_height <=    13    ;
        window_height <=    9    ;
        left_side_mirror_height <=    7    ;
        right_side_mirror_height <=    7    ;
        car_lower_black_space_height <=    5    ;
        end
        20: begin
        car_body_x_pos <=	30	;
        left_headlight_x_pos <=    30    ;
        right_headlight_x_pos <=    72    ;
        left_lowerlight_x_pos <=    34    ;
        right_lowerlight_x_pos <=    78    ;
        nametage_x_pos <=    50    ;
        window_frame_x_pos <=    33    ;
        window_x_pos <=    38    ;
        left_side_mirror_x_pos <=    24    ;
        right_side_mirror_x_pos <=    88    ;
        car_lower_black_space_x_pos <=    40    ;
        //ypos        
        car_body_y_pos <=    17    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    36    ;
        right_lowerlight_y_pos <=    36    ;
        nametage_y_pos <=    36    ;
        window_frame_y_pos <=    3    ;
        window_y_pos <=    8    ;
        left_side_mirror_y_pos <=    17    ;
        right_side_mirror_y_pos <=    17    ;
        car_lower_black_space_y_pos <=    44    ;
        //width        
        car_body_width <=    58    ;
        left_headlight_width <=    16    ;
        right_headlight_width <=    16    ;
        left_lowerlight_width <=    6    ;
        right_lowerlight_width <=    6    ;
        nametage_width <=    18    ;
        window_frame_width <=    52    ;
        window_width <=    42    ;
        left_side_mirror_width <=    6    ;
        right_side_mirror_width <=    6    ;
        car_lower_black_space_width <=    38    ;
        //height        
        car_body_height <=    32    ;
        left_headlight_height <=    7    ;
        right_headlight_height <=    7    ;
        left_lowerlight_height <=    6    ;
        right_lowerlight_height <=    6    ;
        nametage_height <=    16    ;
        window_frame_height <=    14    ;
        window_height <=    9    ;
        left_side_mirror_height <=    7    ;
        right_side_mirror_height <=    7    ;
        car_lower_black_space_height <=    5    ;
        end
        default begin
        car_body_x_pos <=	44	;
        left_headlight_x_pos <=    45    ;
        right_headlight_x_pos <=    57    ;
        left_lowerlight_x_pos <=    45    ;
        right_lowerlight_x_pos <=    59    ;
        nametage_x_pos <=    51    ;
        window_frame_x_pos <=    45    ;
        window_x_pos <=    47    ;
        left_side_mirror_x_pos <=    43    ;
        right_side_mirror_x_pos <=    61    ;
        car_lower_black_space_x_pos <=    47    ;
        //ypos        
        car_body_y_pos <=    22    ;
        left_headlight_y_pos <=    24    ;
        right_headlight_y_pos <=    24    ;
        left_lowerlight_y_pos <=    27    ;
        right_lowerlight_y_pos <=    27    ;
        nametage_y_pos <=    27    ;
        window_frame_y_pos <=    18    ;
        window_y_pos <=    19    ;
        left_side_mirror_y_pos <=    22    ;
        right_side_mirror_y_pos <=    22    ;
        car_lower_black_space_y_pos <=    30    ;
        //width        
        car_body_width <=    17    ;
        left_headlight_width <=    5    ;
        right_headlight_width <=    5    ;
        left_lowerlight_width <=    1    ;
        right_lowerlight_width <=    1    ;
        nametage_width <=    4    ;
        window_frame_width <=    15    ;
        window_width <=    13    ;
        left_side_mirror_width <=    1    ;
        right_side_mirror_width <=    1    ;
        car_lower_black_space_width <=    12    ;
        //height        
        car_body_height <=    9    ;
        left_headlight_height <=    1    ;
        right_headlight_height <=    1    ;
        left_lowerlight_height <=    1    ;
        right_lowerlight_height <=    1    ;
        nametage_height <=    2    ;
        window_frame_height <=    4    ;
        window_height <=    2    ;
        left_side_mirror_height <=    1    ;
        right_side_mirror_height <=    1    ;
        car_lower_black_space_height <=    1    ;
        end
        endcase
    end
    
    reg [31:0] count_for_color_change = 0;
    reg [2:0] color_change_step = 0;
    reg [15:0] orange = 16'hFD20;
    reg [15:0] purple = 16'h4929;
    reg [15:0] blue = 16'h001F;
    reg [15:0] white = 16'hFFFF;
    reg [15:0] red = 16'hF800;
    reg [15:0] gray = 16'h54A9;
    reg [15:0] skyblue = 16'h83DD;
    reg [15:0] green = 16'h07E0;
    // color to be grey after collision animation begin
    always @ (posedge clock_100mhz)begin
        if (frame_counter == 20)begin
            if (count_for_color_change == 49_999_999) begin
                count_for_color_change <= 0;
                if (color_change_step <4)begin
                    color_change_step <= color_change_step + 1;
                    end
                end
            else begin
                count_for_color_change <= count_for_color_change+1;
                end
            end
        else begin
            count_for_color_change <= 0;
            color_change_step <= 0;
            end
        case (color_change_step)
        0 : begin
        orange <= 16'hFD20;
        purple <= 16'h4929;
        blue <= 16'h001F;
        white <= 16'hFFFF;
        red <= 16'hF800;
        gray <= 16'h54A9;
        skyblue <= 16'h83DD;
        green <= 16'h07E0;
        end
        1: begin
        orange <= 16'h8400; //done
        purple <= 16'h38E7; //done
        blue <= 16'h0010; //done
        white <= 16'h8410; //done
        red <= 16'h8000; //done
        gray <= 16'h4327; //done
        skyblue <= 16'h630C;//done
        green <= 16'h0400; //done
        end
        2: begin
        orange <= 16'h7A00; //done
        purple <= 16'h2104; //done
        blue <= 16'h000C; //done
        white <= 16'h7BEF; //done
        red <= 16'h7800; //done
        gray <= 16'h31C4; //done
        skyblue <= 16'h420F; //done
        green <= 16'h0200;
        end
        3: begin
        orange <= 16'h3200; //done
        purple <= 16'h1081; //done
        blue <= 16'h0004; //done
        white <= 16'h3DEF; //done
        red <= 16'h3800; //done
        gray <= 16'h1081; //done
        skyblue <= 16'h2106; //done
        green <= 16'h0100;
        end
        4: begin //done
        orange <= 16'h0000;
        purple <= 16'h0000;
        blue <= 16'h0000;
        white <= 16'h0000; 
        red <= 16'h0000; 
        gray <= 16'h0000;
        skyblue <= 16'h0000;
        green <= 16'h0000;
        end
        default : begin
        orange <= 16'hFD20;
        purple <= 16'h4929;
        blue <= 16'h001F;
        white <= 16'hFFFF;
        red <= 16'hF800;
        gray <= 16'h54A9;
        skyblue <= 16'h83DD;
        green <= 16'h07E0;
        end
        endcase
    end
    //color to be grey after collision animation end
    
    //return to menu begin
        always @ (posedge clock_100mhz)begin
        if (game_active==1 && is_collision==1) begin
            if (color_change_step == 4 && btnC == 1) begin
                return_to_menu <= 1 ; // 
                end
        end
        else begin
            return_to_menu <= 0;
            end
    end
    //return to menu end
    
    //xy coordinate
    wire [6:0] x = pixel_index % 96;
    wire [5:0] y = pixel_index / 96;
    
    //for circle
    wire signed [8:0] dx = $signed({1'b0,x})-54;  //x-center 48
    wire signed [8:0] dy = $signed({1'b0,y})-73; //handle top from base 25, circle size 61, thickness 5 
    wire [16:0] square_dx = dx*dx;
    wire [16:0] square_dy = dy*dy;    
    wire [16:0] square_distance = square_dx + square_dy;
        
    //drawing start
    always @ (posedge clock_100mhz)begin
        //screen after animiation begin
        if (color_change_step == 4) begin
            if ((x >= 24 && x <= 96) && (y >=40  && y <= 48))begin
               oled_data_collision <= 16'hFFFF;
                end
            else begin
                oled_data_collision <= 16'h0000;
                end
        end
        //screen after animiation end
        //drawing pov of driver begin
        else if (square_distance >= 900 && square_distance <= 1225) begin //handle
             oled_data_collision <= orange; //orange
             end
        else if ((x >= 24 && x <= 96) && (y >=45  && y <= 48)) begin //purple line of insde car
                 oled_data_collision <= purple; // 
                 end
        else if (y >= (51 - (x-18)) && //triangle at the end of grey line
                y <= (51 - (10 * (x-18) / 20)) &&  
                x >= 18 && x <= 24 // 
                )begin
                oled_data_collision <= purple; 
                end 
        else if ((x >= 18 && x <= 96) && (y >= 42 && y <= 64)) begin //black square bottom (car display)
            oled_data_collision <= 16'h0000;
            end
        //using trapesium calculation to draw window frame
        else if (x <= (22 + (10 * y) / 40) && // right slent of trapezium 
            x >= (4 + (10 * y) / 30) &&  //left slent of trapezium, every increasement of y will cause x to be increase by 1/3
            y >= 0 && y <= 43 // 
            )begin
            oled_data_collision <= 16'h0000;
            end
        else if (x <= 26 + ((70 * (13-y) * (13-y) + 24)/49) && //top window frame
            x >= (0 + (10 * (y-6)) / 10) &&  
            y >= 6 && y <= 13 // 
            )begin
            oled_data_collision <= 16'h0000;
            end
        else if ((x >= 0 && x <= 96) && (y >= 0 && y <= 6)) begin//top window frame square
                oled_data_collision <= 16'h000;
            end
        else if (y >= (53 - (10 * x) / 20) && //left window frame
            y <= 64 &&  
            x >= 0 && x <= 19 // 
            )begin
            oled_data_collision <= 16'h0000;
            end
        else if ((x >= 0 && x <= 8) && (y >= 46 && y <= 51)) begin//side miirror mirror
            oled_data_collision <= blue; // 
            end
        else if (x <= (9 + (10 * (y-42)) / 10) && //side mirror frame
            x >= 0 &&  
            y >= 42 && y <= 64 // 
            )begin
            oled_data_collision <= purple; 
            end
    //drawing pov of driver begin         
            
            
        //car collision animation begin
        else if (x >= left_headlight_x_pos && x < (left_headlight_x_pos) + (left_headlight_width) && //left headlight
            y >= left_headlight_y_pos && y < (left_headlight_y_pos) + (left_headlight_height)
            )begin
            oled_data_collision <= white;
            end
        else if (x >= right_headlight_x_pos && x < (right_headlight_x_pos) + (right_headlight_width) && //right headlight
            y >= right_headlight_y_pos && y < (right_headlight_y_pos) + (right_headlight_height)
            )begin
            oled_data_collision <= white;
            end  
        else if (x >= left_lowerlight_x_pos && x < (left_lowerlight_x_pos) + (left_lowerlight_width) && //left lowerlight
            y >= left_lowerlight_y_pos && y < (left_lowerlight_y_pos) + (left_lowerlight_height)
            )begin
            oled_data_collision <= white;
            end  
        else if (x >= right_lowerlight_x_pos && x < (right_lowerlight_x_pos) + (right_lowerlight_width) && //right lowerlight
             y >= right_lowerlight_y_pos && y < (right_lowerlight_y_pos) + (right_lowerlight_height)
             )begin
             oled_data_collision <= white;
             end  
        else if (x >= nametage_x_pos && x < (nametage_x_pos) + (nametage_width) && //nametag
            y >= nametage_y_pos && y < (nametage_y_pos) + (nametage_height)
            )begin
            oled_data_collision <= white;
            end  
        else if (x >= window_x_pos && x < (window_x_pos) + (window_width) && //window
            y >= window_y_pos && y < (window_y_pos) + (window_height)
            )begin
            oled_data_collision <= gray; // gray
            end    
        else if (x >= window_frame_x_pos && x < (window_frame_x_pos) + (window_frame_width) && //window frame
            y >= window_frame_y_pos && y < (window_frame_y_pos) + (window_frame_height)
            )begin
            oled_data_collision <= red; // red
            end     
        else if (x >= left_side_mirror_x_pos && x < (left_side_mirror_x_pos) + (left_side_mirror_width) && //left side mirror
            y >= left_side_mirror_y_pos && y < (left_side_mirror_y_pos) + (left_side_mirror_height)
            )begin
            oled_data_collision <= red; // red
            end     
        else if (x >= right_side_mirror_x_pos && x < (right_side_mirror_x_pos) + (right_side_mirror_width) && //right side mirror
            y >= right_side_mirror_y_pos && y < (right_side_mirror_y_pos) + (right_side_mirror_height)
            )begin
            oled_data_collision <= red; // red
            end     
        else if (x >= car_lower_black_space_x_pos && x < (car_lower_black_space_x_pos) + (car_lower_black_space_width) && //car lower black mirror
            y >= car_lower_black_space_y_pos && y < (car_lower_black_space_y_pos) + (car_lower_black_space_height)
            )begin
            oled_data_collision <= 16'h0000; // black
            end     
        else if (x >= car_body_x_pos && x < (car_body_x_pos) + (car_body_width) && //car body
            y >= car_body_y_pos && y < (car_body_y_pos) + (car_body_height)
            )begin
            oled_data_collision <= red; //red
            end 
         //car collision animation end       
        
        
            
        //background begin
        else if (x == (47 - ((14 * (y-26)+8) / 17)) && //middle road green line
            y >= 26 && y <= 42 && !((y-26) & 2'b10) //dots every 3pixels
            )begin
            oled_data_collision <= white; //white
            end
        else if (x <= (57 + (20 * (y-26)) / 10) && //right road white line
            x >= (53 + (20 * (y-26)) / 10) &&
            y >= 26 && y <= 42
            )begin
            oled_data_collision <= white; //white
            end
        else if (x <= (42 - (40 * (y-26)) / 10) && //left road white line
            x >= (36 - (40 * (y-26)) / 10) &&
            y >= 26 && y <= 36
            )begin
            oled_data_collision <= white; //white
            end
        else if (x >= (56 + (20 * (y-26)) / 10) && //right road green
            y >= 26 && y <= 42
            )begin
            oled_data_collision <= green; //green
            end               
        else if (x <= (42 - (40 * (y-26)) / 10) && //left road green
            y >= 26 && y <= 36
            )begin
            oled_data_collision <= green; //green
            end
        else if (y<=25) begin
            oled_data_collision <= skyblue; //skyblue
            end
        else begin
            oled_data_collision <= gray; //grey
        end
    end
    

    
endmodule
