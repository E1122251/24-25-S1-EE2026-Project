`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 13:15:05
// Design Name: 
// Module Name: shield_powerup
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


module shield_powerup (
    input clock_25mhz,
    input [12:0] pixel_index,
    input [1:0] mode,
    input is_obstacle_hitbox_easy,
    input is_obstacle_hitbox_hard, 
    input game_active,
    output reg [15:0] shield_powerup_data,
    output reg is_shield_powerup_hitbox
);

    localparam YELLOW = 16'b11111_111111_00000;
    localparam LANE_HEIGHT = 16;
    localparam TOTAL_LANES = 4;

    reg [31:0] timer = 0;
    reg [31:0] shield_timer = 0;
    reg [1:0] current_lane = 0;
    reg shield_active = 0;
    reg shield_visible = 0;

    reg [6:0] shield_x;
    reg [5:0] shield_y;

    wire [6:0] x_coord = pixel_index % 96;
    wire [5:0] y_coord = pixel_index / 96;

    localparam DELAY = 4 * 25_000_000;       
    localparam DISPLAY_TIME = 100000000; 

    reg [31:0] random_seed = 32'hEDCBA321;
    always @(posedge clock_25mhz) begin
        random_seed <= {random_seed[30:0], random_seed[31] ^ random_seed[28] ^ random_seed[16] ^ random_seed[5]};
    end

    initial begin
        shield_x = random_seed % 92; 
        shield_y = current_lane * LANE_HEIGHT; 
        shield_active = 0;
        shield_visible = 0;
    end

    always @(posedge clock_25mhz) begin
       if(game_active) begin
        if (mode == 2'b00 || mode == 2'b10 || mode==2'b11) begin  
            if (timer < DELAY) begin
                timer <= timer + 1;
            end else if (!shield_active) begin
                shield_active <= 1;
                shield_visible <= 1;
                shield_timer <= 0;
                shield_y <= current_lane * LANE_HEIGHT;
                shield_x <= random_seed % 92;  
            end else if (shield_visible) begin
                if (shield_timer < DISPLAY_TIME) begin
                    shield_timer <= shield_timer + 1;
                end else begin
                    shield_visible <= 0;  
                end
            end else if (timer < DELAY + 4 * 25_000_000) begin
                timer <= timer + 1;
            end else begin
                timer <= DELAY;  
                current_lane <= (current_lane + 1) % TOTAL_LANES;
                shield_y <= current_lane * LANE_HEIGHT;
                shield_x <= random_seed % 92;
                shield_visible <= 1;
                shield_timer <= 0;
            end
        end else begin
            timer <= 0;
            shield_active <= 0;
            shield_visible <= 0;
        end
      end else begin 
        timer = 0;
        shield_active = 0;
        shield_visible = 0;
        shield_timer = 0;
      end
    end

    always @(*) begin
      if(game_active) begin
        shield_powerup_data = 16'b00000_000000_00000;
        is_shield_powerup_hitbox = 0;

        if (shield_visible && shield_active && (mode == 2'b00 || mode == 2'b10 || mode == 2'b11) && 
            !is_obstacle_hitbox_easy && !is_obstacle_hitbox_hard) begin  
            if ((x_coord >= shield_x && x_coord < shield_x + 5) && 
                (y_coord >= shield_y && y_coord < shield_y + 5)) begin
                shield_powerup_data = YELLOW;
                is_shield_powerup_hitbox = 1;
            end
        end
       end else begin
         shield_powerup_data = 16'b00000_000000_00000;
         is_shield_powerup_hitbox = 0;
       end
    end
endmodule