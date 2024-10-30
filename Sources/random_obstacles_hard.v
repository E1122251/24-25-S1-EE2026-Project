`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2024 14:35:01
// Design Name: 
// Module Name: random_obstacles_hard
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


module random_obstacles_hard (
    input clock_25mhz,
    input [12:0] pixel_index,
    input [31:0] speed,
    input game_active,
    output reg [15:0] obstacle_data,
    output reg is_obstacle_hitbox
);

    
    reg [6:0] obstacle_x1 = 96; 
    reg [6:0] obstacle_x2 = 48; 
    reg [5:0] obstacle_y1 = 10; 
    reg [5:0] obstacle_y2 = 38;  

    wire [6:0] x_coord;
    wire [5:0] y_coord;

    assign x_coord = pixel_index % 96;
    assign y_coord = pixel_index / 96;

 
    localparam OBSTACLE_COLOR = 16'b11111_000000_11111; 
    localparam OBSTACLE_WIDTH = 10;  
    localparam OBSTACLE_HEIGHT = 8;  
    localparam Y_BOUNDARY_TOP = 0;
    localparam Y_BOUNDARY_BOTTOM = 63;

    reg [31:0] obstacle_scroll_counter = 0;

    
    reg [31:0] random_seed = 32'hABCDE123;
    reg [5:0] random_value_y1, random_value_y2;

  
//    initial begin
//        obstacle_x1 = 96;  
//        obstacle_x2 = 48;  
//        obstacle_y1 = 10;  
//        obstacle_y2 = 40;  
//    end

    
    always @(posedge clock_25mhz) begin
        random_seed <= {random_seed[30:0], random_seed[31] ^ random_seed[21] ^ random_seed[14] ^ random_seed[0]};
        
        case (random_seed % 4)
            0: random_value_y1 <= 0;   
            1: random_value_y1 <= 18;   
            2: random_value_y2 <= 35;   
            3: random_value_y2 <= 51;   
        endcase
    end

    // Obstacle movement logic
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

            // Bottom two lanes: Move from right to left (flipped)
            if (obstacle_x2 > 0) begin
                obstacle_x2 <= obstacle_x2 - 1;
            end else begin
                obstacle_x2 <= 96; 
                obstacle_y2 <= random_value_y2;  
            end
        end
       end else begin 
         obstacle_scroll_counter = 0;
         obstacle_x1 = 0; 
         obstacle_x2 = 0; 
         obstacle_y1 = 10; 
         obstacle_y2 = 38;
       end
    end

    
    wire is_obstacle_wheels_1, is_obstacle_chassis_1, is_obstacle_wheels_2, is_obstacle_chassis_2;

    // Regular car (top lanes)
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

    // Flipped car (bottom lanes)
    assign is_obstacle_wheels_2 = (
       
        (x_coord >= (obstacle_x2 + 7) && x_coord <= (obstacle_x2 + 8) && y_coord >= (obstacle_y2) && y_coord <= (obstacle_y2 + 1)) ||
        (x_coord >= (obstacle_x2 + 3) && x_coord <= (obstacle_x2 + 4) && y_coord >= (obstacle_y2) && y_coord <= (obstacle_y2 + 1)) ||
        (x_coord >= (obstacle_x2 + 7) && x_coord <= (obstacle_x2 + 8) && y_coord >= (obstacle_y2 + 6) && y_coord <= (obstacle_y2 + 7)) ||
        (x_coord >= (obstacle_x2 + 3) && x_coord <= (obstacle_x2 + 4) && y_coord >= (obstacle_y2 + 6) && y_coord <= (obstacle_y2 + 7))
    );

    assign is_obstacle_chassis_2 = (
       
        (x_coord >= (obstacle_x2 + 1) && x_coord <= (obstacle_x2 + 9) && y_coord >= (obstacle_y2 + 2) && y_coord <= (obstacle_y2 + 5)) ||
        (x_coord == (obstacle_x2) && y_coord >= (obstacle_y2 + 3) && y_coord <= (obstacle_y2 + 4))
    );

    
    always @(*) begin
      if (game_active) begin
        if (is_obstacle_wheels_1 || is_obstacle_chassis_1) begin
            obstacle_data <= OBSTACLE_COLOR;
            is_obstacle_hitbox <= 1;
        end else if (is_obstacle_wheels_2 || is_obstacle_chassis_2) begin
            obstacle_data <= OBSTACLE_COLOR;
            is_obstacle_hitbox <= 1;
        end else begin
            obstacle_data = 16'b00000_000000_00000;
            is_obstacle_hitbox = 0;
        end
      end else begin
        obstacle_data = 16'b00000_000000_00000;  
        is_obstacle_hitbox = 0; 
      end
    end
endmodule      