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
    output reg [15:0] obstacle_data,
    output reg is_obstacle_hitbox  
);

    
    reg [6:0] obstacle_x1 = 96;  
    reg [6:0] obstacle_x2 = 48;  
    reg [5:0] obstacle_y1 = 10;  
    reg [5:0] obstacle_y2 = 40;  

    wire [6:0] x_coord;
    wire [5:0] y_coord;

    assign x_coord = pixel_index % 96; 
    assign y_coord = pixel_index / 96;  

    // Obstacle parameters
    localparam OBSTACLE_COLOR = 16'b11111_000000_11111;  // Purple color
    localparam OBSTACLE_WIDTH = 3;  // Width of the obstacle
    localparam Y_BOUNDARY_TOP = 5;
    localparam Y_BOUNDARY_BOTTOM = 58;

    
    reg [31:0] obstacle_scroll_counter = 0;

    // Random number generation for positions
    reg [31:0] random_seed = 32'hABCDE123;  // Initial seed for randomness
    reg [6:0] random_value_x;  
    reg [5:0] random_value_y;  

    // Initialize obstacle positions
    initial begin
        obstacle_x1 = 96;  // Start first obstacle at the far right
        obstacle_x2 = 48;  // Start second obstacle in the middle
        obstacle_y1 = 10;  // Top lane for obstacle 1
        obstacle_y2 = 40;  // Bottom lane for obstacle 2
    end

    // RNG
    always @(posedge clock_25mhz) begin
        random_seed <= {random_seed[30:0], random_seed[31] ^ random_seed[21] ^ random_seed[1] ^ random_seed[0]};
        random_value_x <= random_seed % 96; 
        random_value_y <= random_seed % (Y_BOUNDARY_BOTTOM - Y_BOUNDARY_TOP - OBSTACLE_WIDTH + 1) + Y_BOUNDARY_TOP;
    end

    // Obstacle movement logic (right to left)
    always @(posedge clock_25mhz) begin
        if (obstacle_scroll_counter < speed) begin
            obstacle_scroll_counter <= obstacle_scroll_counter + 1;
        end else begin
            obstacle_scroll_counter <= 0;

            // Move obstacles from right to left
            if (obstacle_x1 > 0) begin
                obstacle_x1 <= obstacle_x1 - 1;
            end else begin
                // Reset to random positions after reaching the left side
                obstacle_x1 <= 96;  // Reset to the right side of the screen
                obstacle_y1 <= random_value_y;  // Assign a random Y position within boundaries
            end

            if (obstacle_x2 > 0) begin
                obstacle_x2 <= obstacle_x2 - 1;
            end else begin
                obstacle_x2 <= 96; 
                obstacle_y2 <= random_value_y;  
            end
        end
    end

    always @(*) begin
        obstacle_data <= 16'b00000_000000_00000;
        is_obstacle_hitbox <= 0;  

        // Check if the current pixel matches the obstacle position
        // Obstacle 1 (moving from right to left)
        if (y_coord >= obstacle_y1 && y_coord <= obstacle_y1 + OBSTACLE_WIDTH &&
            x_coord >= obstacle_x1 && x_coord <= obstacle_x1 + OBSTACLE_WIDTH) begin
            obstacle_data <= OBSTACLE_COLOR;
            is_obstacle_hitbox <= 1;  
        end
        
        // Obstacle 2 (moving from right to left)
        if (y_coord >= obstacle_y2 && y_coord <= obstacle_y2 + OBSTACLE_WIDTH &&
            x_coord >= obstacle_x2 && x_coord <= obstacle_x2 + OBSTACLE_WIDTH) begin
            obstacle_data <= OBSTACLE_COLOR;
            is_obstacle_hitbox <= 1; 
        end
    end
endmodule







