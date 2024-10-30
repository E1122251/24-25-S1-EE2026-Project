`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 18:36:30
// Design Name: 
// Module Name: speed_ramp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 


module speed_ramp (
    input clock_25mhz,
    input [12:0] pixel_index,
    input [1:0] mode,
    input is_shield_powerup_hitbox,  
    input is_obstacle_hitbox_easy,
    input game_active,
    output reg [15:0] speed_ramp_data,
    output reg is_speed_ramp_hitbox,
    output reg [1:0] active_lane  
);

    localparam DARKER_GREEN = 16'b00011_011110_00011;  
    localparam LANE_HEIGHT = 16;                
    localparam TOTAL_LANES = 4;                
    localparam DELAY_12_SEC = 12 * 25_000_000;
    localparam ACTIVE_DURATION = 100_000_000;

    reg [31:0] delay_timer = 0;
    reg [31:0] active_timer = 0;
    reg speed_ramp_active = 0;
    reg [6:0] arrow1_start_x = 20;

    wire [6:0] x_coord = pixel_index % 96;
    wire [5:0] y_coord = pixel_index / 96;

    initial begin
        active_lane = 0;
        speed_ramp_active = 0;
    end

    always @(posedge clock_25mhz) begin
       if(game_active) begin
        if (mode == 2'b00 || mode == 2'b01 || mode == 2'b10 || mode==2'b11) begin  
            if (!speed_ramp_active && delay_timer < DELAY_12_SEC) begin
                delay_timer <= delay_timer + 1;
            end else if (!is_obstacle_hitbox_easy && !is_shield_powerup_hitbox && !speed_ramp_active) begin
                speed_ramp_active <= 1;
                active_timer <= 0;
                delay_timer <= 0;
                arrow1_start_x <= (arrow1_start_x < 30) ? arrow1_start_x + 1 : 20;
            end else if (active_timer < ACTIVE_DURATION) begin
                active_timer <= active_timer + 1;
            end else begin
                speed_ramp_active <= 0;
                active_timer <= 0;
                active_lane <= (active_lane + 1) % TOTAL_LANES;
            end
        end else begin
            delay_timer <= 0;
            active_timer <= 0;
            speed_ramp_active <= 0;
        end
      end else begin
        speed_ramp_active = 0;
        active_timer = 0;
        delay_timer = 0;
      end 
    end

    wire [5:0] lane_y_start = active_lane * LANE_HEIGHT;
    wire [5:0] lane_y_end = lane_y_start + LANE_HEIGHT - 1;

    localparam ARROW_WIDTH = 4;
    localparam SPACING = 5;

    wire [6:0] arrow2_start_x = arrow1_start_x + ARROW_WIDTH + SPACING;
    wire [6:0] arrow3_start_x = arrow2_start_x + ARROW_WIDTH + SPACING;
    wire [6:0] arrow4_start_x = arrow3_start_x + ARROW_WIDTH + SPACING;

    always @(*) begin
      if (game_active) begin
        speed_ramp_data = 16'b00000_000000_00000;
        is_speed_ramp_hitbox = 0;

        if (speed_ramp_active && (mode == 2'b00 || mode == 2'b01 || mode == 2'b10 || mode==2'b11) && !is_shield_powerup_hitbox && !is_obstacle_hitbox_easy) begin
            // Hollow arrow 1
            if ((y_coord == lane_y_start + 2 && x_coord == arrow1_start_x) ||
                (y_coord == lane_y_end - 2 && x_coord == arrow1_start_x) ||
                (y_coord == lane_y_start + 4 && x_coord == arrow1_start_x + 1) ||
                (y_coord == lane_y_end - 4 && x_coord == arrow1_start_x + 1) ||
                (y_coord == lane_y_start + 6 && x_coord == arrow1_start_x + 2) ||
                (y_coord == lane_y_end - 6 && x_coord == arrow1_start_x + 2) ||
                (y_coord == lane_y_start + 8 && x_coord == arrow1_start_x + 3) ||
                (y_coord == lane_y_end - 8 && x_coord == arrow1_start_x + 3)) begin
                speed_ramp_data = DARKER_GREEN;
                is_speed_ramp_hitbox = 1;
            end 
            // Hollow arrow 2
            else if ((y_coord == lane_y_start + 2 && x_coord == arrow2_start_x) ||
                     (y_coord == lane_y_end - 2 && x_coord == arrow2_start_x) ||
                     (y_coord == lane_y_start + 4 && x_coord == arrow2_start_x + 1) ||
                     (y_coord == lane_y_end - 4 && x_coord == arrow2_start_x + 1) ||
                     (y_coord == lane_y_start + 6 && x_coord == arrow2_start_x + 2) ||
                     (y_coord == lane_y_end - 6 && x_coord == arrow2_start_x + 2) ||
                     (y_coord == lane_y_start + 8 && x_coord == arrow2_start_x + 3) ||
                     (y_coord == lane_y_end - 8 && x_coord == arrow2_start_x + 3)) begin
                speed_ramp_data = DARKER_GREEN;
                is_speed_ramp_hitbox = 1;
            end
            // Hollow arrow 3
            else if ((y_coord == lane_y_start + 2 && x_coord == arrow3_start_x) ||
                     (y_coord == lane_y_end - 2 && x_coord == arrow3_start_x) ||
                     (y_coord == lane_y_start + 4 && x_coord == arrow3_start_x + 1) ||
                     (y_coord == lane_y_end - 4 && x_coord == arrow3_start_x + 1) ||
                     (y_coord == lane_y_start + 6 && x_coord == arrow3_start_x + 2) ||
                     (y_coord == lane_y_end - 6 && x_coord == arrow3_start_x + 2) ||
                     (y_coord == lane_y_start + 8 && x_coord == arrow3_start_x + 3) ||
                     (y_coord == lane_y_end - 8 && x_coord == arrow3_start_x + 3)) begin
                speed_ramp_data = DARKER_GREEN;
                is_speed_ramp_hitbox = 1;
            end
            // Hollow arrow 4
            else if ((y_coord == lane_y_start + 2 && x_coord == arrow4_start_x) ||
                     (y_coord == lane_y_end - 2 && x_coord == arrow4_start_x) ||
                     (y_coord == lane_y_start + 4 && x_coord == arrow4_start_x + 1) ||
                     (y_coord == lane_y_end - 4 && x_coord == arrow4_start_x + 1) ||
                     (y_coord == lane_y_start + 6 && x_coord == arrow4_start_x + 2) ||
                     (y_coord == lane_y_end - 6 && x_coord == arrow4_start_x + 2) ||
                     (y_coord == lane_y_start + 8 && x_coord == arrow4_start_x + 3) ||
                     (y_coord == lane_y_end - 8 && x_coord == arrow4_start_x + 3)) begin
                speed_ramp_data = DARKER_GREEN;
                is_speed_ramp_hitbox = 1;
            end
        end
       end else begin
         speed_ramp_data = 16'b00000_000000_00000;
         is_speed_ramp_hitbox = 0;
       end
    end
endmodule