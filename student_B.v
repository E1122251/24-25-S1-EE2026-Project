`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//////////////////////////////////////////////////////////////////////////////////


module student_B (
    input clock_100mhz,
    input btnC,
    input btnU,
    input btnD,
    input password_B,
    input [12:0] pixel_index,
    output reg [15:0] oled_data,
    output reg [15:0] led
);
  
    wire clock_6p25mhz;
    wire clock_25mhz;
    wire clock_1khz;
    wire frame_begin;
    wire sending_pixels;

    flexi_clock clk6p25(.clk(clock_100mhz), .m(8), .slow_clk(clock_6p25mhz));
    flexi_clock clk25Mhz(.clk(clock_100mhz), .m(4), .slow_clk(clock_25mhz));

    reg [6:0] road_offset = 0; 
    wire [6:0] effective_x_coord;
    
    // Define the scrolling speed - how frequently the offset changes
    localparam SCROLL_SPEED_DIVIDER = 500000; // Adjust to control speed
    reg [31:0] scroll_counter = 0;
    
    // Update the road offset to simulate scrolling
    always @(posedge clock_25mhz) begin
        if (scroll_counter < SCROLL_SPEED_DIVIDER) begin
            scroll_counter <= scroll_counter + 1;
        end else begin
            scroll_counter <= 0;
            if (road_offset < 96) begin
                road_offset <= road_offset + 1;
            end else begin
                road_offset <= 0;  // Wrap around when it reaches the screen limit
            end
        end
    end
    
   
    wire [6:0] x_coord;
    wire [5:0] y_coord;
    assign x_coord = pixel_index % 96;
    assign y_coord = pixel_index / 96;
    assign effective_x_coord = (x_coord + road_offset) % 96;

    // Instantiate the random_obstacles module with speed control
    wire [15:0] obstacle_data;
    wire is_obstacle_hitbox;
    random_obstacles obstacle_gen(
        .clock_25mhz(clock_25mhz),
        .pixel_index(pixel_index),
        .speed(100000),  // Pass the desired speed here
        .obstacle_data(obstacle_data),
        .is_obstacle_hitbox(is_obstacle_hitbox)
    );
    
   always @(posedge clock_25mhz) begin
            if (password_B) begin
                oled_data = 16'b00000_000000_00000;  // Default black for all pixels.
    
                
                if (obstacle_data != 16'b00000_000000_00000) begin
                    oled_data <= obstacle_data;
                end 
                
                else begin
                    // Entire road background
                    if ((y_coord >= 10 && y_coord <= 53)) begin
                        oled_data <= 16'b00000_000000_00000; // Black for the road
                    end
    
                    // Road borders (blue) - only two, at the top and bottom
                    if ((y_coord == 5 || y_coord == 58)) begin
                        oled_data <= 16'b00000_011000_11111; // blue for the road borders
                    end
    
                    // Dashed lines with solid middle line
                    if ((y_coord >= 18 && y_coord <= 19) && ((effective_x_coord % 16) < 10)) begin
                        oled_data <= 16'b01100_011000_01100; // white for the top dashed line
                    end
    
                    // Solid middle blue line (spans the entire width)
                    if ((y_coord >= 30 && y_coord <= 31)) begin
                        oled_data <= 16'b00000_011000_11111; // blue for the solid middle line
                    end
    
                    // Dashed line at the bottom
                    if ((y_coord >= 44 && y_coord <= 45) && ((effective_x_coord % 16) < 10)) begin
                        oled_data <= 16'b01100_011000_01100; // white for the bottom dashed line
                    end
                end
            end else begin
                oled_data = 16'b00000_000000_00000; 
            end
        end
    endmodule
