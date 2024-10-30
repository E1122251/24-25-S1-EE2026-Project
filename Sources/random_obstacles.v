`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2024 17:26:10
// Design Name: 
// Module Name: random_obstacles
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


module random_obstacles (
    input clock_25mhz,
    input [12:0] pixel_index,
    input [31:0] speed, 
    input [1:0] mode,         
    input [1:0] active_lane, 
    input game_active,
    output reg [15:0] obstacle_data,
    output reg is_obstacle_hitbox
);

    reg [6:0] obstacle_x1 = 0;  
    reg [6:0] obstacle_x2 = 48;  
    reg [5:0] obstacle_y1 = 10;  
    reg [5:0] obstacle_y2 = 40;  

    wire [6:0] x_coord;
    wire [5:0] y_coord;

    assign x_coord = pixel_index % 96;  
    assign y_coord = pixel_index / 96;  

    localparam OBSTACLE_COLOR = 16'b11111_000000_11111;
    localparam OBSTACLE_WIDTH = 10;  
    localparam OBSTACLE_HEIGHT = 8;  
    localparam LANE_HEIGHT = 16;

    reg [31:0] obstacle_scroll_counter = 0;
    reg [31:0] random_seed = 32'hABCDE123;  
    reg [5:0] random_value_y1, random_value_y2;

    always @(posedge clock_25mhz) begin
        random_seed <= {random_seed[30:0], random_seed[31] ^ random_seed[20] ^ random_seed[11] ^ random_seed[0]};
        
        if (mode == 2'b01) begin
            // In mode 01, ignore active_lane and allow obstacles in all lanes
            case (random_seed % 4)
                0: random_value_y1 <= 0;   
                1: random_value_y1 <= 18;  
                2: random_value_y1 <= 35;  
                3: random_value_y1 <= 51;  
            endcase
            
            case ((random_seed + 23) % 4)
                0: random_value_y2 <= 0;   
                1: random_value_y2 <= 18;  
                2: random_value_y2 <= 35;  
                3: random_value_y2 <= 51;  
            endcase
        end else begin
            // For other modes, avoid the active_lane for obstacle generation
            case (random_seed % 4)
                0: random_value_y1 <= (active_lane == 0) ? 18 : 0;   
                1: random_value_y1 <= (active_lane == 1) ? 35 : 18;  
                2: random_value_y1 <= (active_lane == 2) ? 51 : 35;  
                3: random_value_y1 <= (active_lane == 3) ? 0 : 51;  
            endcase
            
            case ((random_seed + 23) % 4)
                0: random_value_y2 <= (active_lane == 0) ? 18 : 0;   
                1: random_value_y2 <= (active_lane == 1) ? 35 : 18;  
                2: random_value_y2 <= (active_lane == 2) ? 51 : 35;  
                3: random_value_y2 <= (active_lane == 3) ? 0 : 51;  
            endcase
        end
    end

    always @(posedge clock_25mhz) begin
      if(game_active) begin
        if (obstacle_scroll_counter < speed) begin
            obstacle_scroll_counter <= obstacle_scroll_counter + 1;
        end else begin
            obstacle_scroll_counter <= 0;

            if (obstacle_x1 < 96) begin
                obstacle_x1 <= obstacle_x1 + 1;
            end else begin
                obstacle_x1 <= 0;
                obstacle_y1 <= random_value_y1;  
            end

            if (obstacle_x2 < 96) begin
                obstacle_x2 <= obstacle_x2 + 1;
            end else begin
                obstacle_x2 <= 0;
                obstacle_y2 <= random_value_y2;  
            end
        end
       end else begin 
         obstacle_scroll_counter = 0;
         obstacle_x1 = 0;  
         obstacle_x2 = 48;  
         obstacle_y1 = 10;  
         obstacle_y2 = 40;
       end
    end

    wire is_obstacle_wheels_1, is_obstacle_chassis_1, is_obstacle_wheels_2, is_obstacle_chassis_2;

    assign is_obstacle_wheels_1 = (
        (x_coord >= (obstacle_x1 + 1) && x_coord <= (obstacle_x1 + 2) && y_coord >= (obstacle_y1) && y_coord <= (obstacle_y1 + 1)) ||
        (x_coord >= (obstacle_x1 + 5) && x_coord <= (obstacle_x1 + 6) && y_coord >= (obstacle_y1) && y_coord <= (obstacle_y1 + 1)) ||
        (x_coord >= (obstacle_x1 + 1) && x_coord <= (obstacle_x1 + 2) && y_coord >= (obstacle_y1 + 6) && y_coord <= (obstacle_y1 + 7)) ||
        (x_coord >= (obstacle_x1 + 5) && x_coord <= (obstacle_x1 + 6) && y_coord >= (obstacle_y1 + 6) && y_coord <= (obstacle_y1 + 7))
    );

    assign is_obstacle_chassis_1 = (
        (x_coord >= (obstacle_x1) && x_coord <= (obstacle_x1 + 8) && y_coord >= (obstacle_y1 + 2) && y_coord <= (obstacle_y1 + 5)) ||
        (x_coord == (obstacle_x1 + 9) && y_coord >= (obstacle_y1 + 3) && y_coord <= (obstacle_y1 + 4))
    );

    assign is_obstacle_wheels_2 = (
        (x_coord >= (obstacle_x2 + 1) && x_coord <= (obstacle_x2 + 2) && y_coord >= (obstacle_y2) && y_coord <= (obstacle_y2 + 1)) ||
        (x_coord >= (obstacle_x2 + 5) && x_coord <= (obstacle_x2 + 6) && y_coord >= (obstacle_y2) && y_coord <= (obstacle_y2 + 1)) ||
        (x_coord >= (obstacle_x2 + 1) && x_coord <= (obstacle_x2 + 2) && y_coord >= (obstacle_y2 + 6) && y_coord <= (obstacle_y2 + 7)) ||
        (x_coord >= (obstacle_x2 + 5) && x_coord <= (obstacle_x2 + 6) && y_coord >= (obstacle_y2 + 6) && y_coord <= (obstacle_y2 + 7))
    );

    assign is_obstacle_chassis_2 = (
        (x_coord >= (obstacle_x2) && x_coord <= (obstacle_x2 + 8) && y_coord >= (obstacle_y2 + 2) && y_coord <= (obstacle_y2 + 5)) ||
        (x_coord == (obstacle_x2 + 9) && y_coord >= (obstacle_y2 + 3) && y_coord <= (obstacle_y2 + 4))
    );

    always @(*) begin
      if(game_active) begin
        obstacle_data = 16'b00000_000000_00000;
        is_obstacle_hitbox = 0;

        if (is_obstacle_wheels_1 || is_obstacle_chassis_1) begin
            obstacle_data <= OBSTACLE_COLOR;
            is_obstacle_hitbox <= 1;
        end else if (is_obstacle_wheels_2 || is_obstacle_chassis_2) begin
            obstacle_data <= OBSTACLE_COLOR;
            is_obstacle_hitbox <= 1;
        end
      end else begin
        obstacle_data = 16'b00000_000000_00000;
        is_obstacle_hitbox = 0;
      end
    end
endmodule 