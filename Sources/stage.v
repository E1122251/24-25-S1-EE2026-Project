`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//////////////////////////////////////////////////////////////////////////////////

module stage (
    input clock_100mhz,
    input game_active,
    input [12:0] pixel_index,
    input [1:0] mode,  // mode 00: normal, 01: endless with gradual increase (fwd moving)
    // 10: hard mode(backwd moving, has shield), 11: gradual increase w hard obstacles and shield
    output reg [15:0] oled_data,
    output selected_obstacle_hitbox,
    output is_speed_ramp_hitbox,       
    output is_shield_powerup_hitbox    
);
  
    wire clock_25mhz;
    flexi_clock clk25Mhz(.clk(clock_100mhz), .m(2), .slow_clk(clock_25mhz));

    reg [6:0] road_offset_top = 0;
    reg [6:0] road_offset_bottom = 0; 
    wire [6:0] effective_x_coord_top;
    wire [6:0] effective_x_coord_middle;
    wire [6:0] effective_x_coord_bottom;

    localparam DEFAULT_SCROLL_SPEED_DIVIDER = 800000;
    localparam DEFAULT_OBSTACLE_SPEED = 800000;
    localparam MIN_SCROLL_SPEED_DIVIDER = 200000;  
    localparam MIN_OBSTACLE_SPEED = 200000;  

    reg [31:0] scroll_speed_divider = DEFAULT_SCROLL_SPEED_DIVIDER;
    reg [31:0] obstacle_speed = DEFAULT_OBSTACLE_SPEED;
    reg [31:0] scroll_counter = 0;
    reg [31:0] mode01_speed_increment = 200;  
    
    always @(posedge clock_25mhz) begin
      if(game_active) begin
        if (scroll_counter < scroll_speed_divider) begin
            scroll_counter <= scroll_counter + 1;
        end else begin
            scroll_counter <= 0;

            if (road_offset_top < 96) begin
                road_offset_top <= road_offset_top + 1;
            end else begin
                road_offset_top <= 0;
            end

            // Adjust scroll and obstacle speed for modes 01 and 11
            if (mode == 2'b01 || mode == 2'b11) begin
                if (scroll_speed_divider > MIN_SCROLL_SPEED_DIVIDER) begin
                    scroll_speed_divider <= scroll_speed_divider - mode01_speed_increment;
                end
                if (obstacle_speed > MIN_OBSTACLE_SPEED) begin
                    obstacle_speed <= obstacle_speed - mode01_speed_increment;
                end
            end
            
            if (road_offset_bottom < 96) begin
                road_offset_bottom <= road_offset_bottom + 1;
            end else begin
                road_offset_bottom <= 0;
            end
        end
       end else begin
         scroll_speed_divider = DEFAULT_SCROLL_SPEED_DIVIDER;
         obstacle_speed = DEFAULT_OBSTACLE_SPEED;
         scroll_counter = 0;
       end 
    end

    wire [6:0] x_coord;
    wire [5:0] y_coord;
    assign x_coord = pixel_index % 96;
    assign y_coord = pixel_index / 96;

    assign effective_x_coord_top = (x_coord + road_offset_top) % 96;
    assign effective_x_coord_middle = (x_coord + road_offset_top) % 96; 
    assign effective_x_coord_bottom = (x_coord + road_offset_bottom) % 96;

    wire [15:0] obstacle_data_easy, obstacle_data_hard;
    wire is_obstacle_hitbox_easy, is_obstacle_hitbox_hard;

    wire [1:0] active_lane;

    
    random_obstacles obstacle_gen_easy(
        .clock_25mhz(clock_25mhz),
        .pixel_index(pixel_index),
        .speed(obstacle_speed),  
        .obstacle_data(obstacle_data_easy),
        .is_obstacle_hitbox(is_obstacle_hitbox_easy),
        .active_lane(active_lane),
        .mode(mode),
        .game_active(game_active)
    );

    random_obstacles_hard obstacle_gen_hard(
        .clock_25mhz(clock_25mhz),
        .pixel_index(pixel_index),
        .speed(obstacle_speed),  
        .obstacle_data(obstacle_data_hard),
        .is_obstacle_hitbox(is_obstacle_hitbox_hard),
        .game_active(game_active)
    );

    wire [15:0] selected_obstacle_data;
    assign selected_obstacle_hitbox = (mode == 2'b00 || mode == 2'b01) ? is_obstacle_hitbox_easy : is_obstacle_hitbox_hard;
    assign selected_obstacle_data = (mode == 2'b00 || mode == 2'b01) ? obstacle_data_easy : obstacle_data_hard;

    wire [15:0] shield_powerup_data;
    shield_powerup shield_gen(
        .clock_25mhz(clock_25mhz),
        .pixel_index(pixel_index),
        .mode(mode),
        .is_obstacle_hitbox_easy(is_obstacle_hitbox_easy),
        .is_obstacle_hitbox_hard(is_obstacle_hitbox_hard),  
        .shield_powerup_data(shield_powerup_data),
        .is_shield_powerup_hitbox(is_shield_powerup_hitbox),
        .game_active(game_active)
    );

    wire [15:0] speed_ramp_data;
    speed_ramp speed_ramp_gen(
        .clock_25mhz(clock_25mhz),
        .pixel_index(pixel_index),
        .mode(mode),
        .is_shield_powerup_hitbox(is_shield_powerup_hitbox),
        .is_obstacle_hitbox_easy(selected_obstacle_hitbox),
        .speed_ramp_data(speed_ramp_data),
        .is_speed_ramp_hitbox(is_speed_ramp_hitbox),
        .active_lane(active_lane),
        .game_active(game_active)
    );

    always @(posedge clock_25mhz) begin
        if (game_active) begin
            oled_data <= 16'b00000_000000_00000;

            if (is_speed_ramp_hitbox && !is_shield_powerup_hitbox && !selected_obstacle_hitbox) begin
                oled_data <= speed_ramp_data;
            end else if (is_shield_powerup_hitbox && !selected_obstacle_hitbox) begin
                oled_data <= shield_powerup_data;
            end else if (selected_obstacle_hitbox) begin
                oled_data <= selected_obstacle_data;
            end else begin
                if ((y_coord >= 0 && y_coord <= 63)) begin
                    oled_data <= 16'b00000_000000_00000;
                end
                if ((y_coord >= 14 && y_coord <= 15) && ((effective_x_coord_top % 16) < 10)) begin
                    oled_data <= 16'b01100_011000_01100;
                end
                if ((y_coord >= 31 && y_coord <= 32)) begin
                    oled_data <= 16'b00000_011000_11111;
                end
                if ((y_coord >= 47 && y_coord <= 48) && ((effective_x_coord_bottom % 16) < 10)) begin
                    oled_data <= 16'b01100_011000_01100;
                end
            end
        end else begin
            oled_data <= 16'b00000_000000_00000;
        end
    end
endmodule 

