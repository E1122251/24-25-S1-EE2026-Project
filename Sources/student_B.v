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
  flexi_clock clk1khz(.clk(clock_100mhz), .m(100000), .slow_clk(clock_1khz));


  wire [6:0] x_coord;   
  wire [5:0] y_coord;   
  
  assign x_coord = pixel_index % 96;
  assign y_coord = pixel_index / 96;

  wire up_debounced;
  wire centre_debounced;
  wire down_debounced;

  debounce_button debounce_up(.clock_100mhz(clock_100mhz), .btn_in(btnU),
                              .btn_out(up_debounced));
  debounce_button debounce_centre(.clock_100mhz(clock_100mhz), .btn_in(btnC),
                                  .btn_out(centre_debounced));
  debounce_button debounce_down(.clock_100mhz(clock_100mhz), .btn_in(btnD),
                                .btn_out(down_debounced));

  localparam WHITE = 2'b00;
  localparam RED   = 2'b01;
  localparam GREEN = 2'b10;
  localparam BLUE  = 2'b11;

  reg [1:0] square1_color = WHITE;
  reg [1:0] square2_color = WHITE;
  reg [1:0] square3_color = WHITE;

  reg reset_done = 0;
  localparam FREQ_DIV_3HZ = 32'd16666667;
  
  wire led9_blink, led6_blink, led5_blink, led2_blink, led0_blink;
    
    blink_led_B led0_blinker (
          .clk(clock_100mhz),
          .freq_div(FREQ_DIV_3HZ),
          .enable(password_B),    
          .led(led0_blink)
      );
    
    blink_led_B led9_blinker (
        .clk(clock_100mhz),
        .freq_div(FREQ_DIV_3HZ),
        .enable(password_B),    
        .led(led9_blink)
    );
  
    blink_led_B led6_blinker (
        .clk(clock_100mhz),
        .freq_div(FREQ_DIV_3HZ),
        .enable(password_B),    
        .led(led6_blink)
    );
  
    blink_led_B led5_blinker (
        .clk(clock_100mhz),
        .freq_div(FREQ_DIV_3HZ),
        .enable(password_B),    
        .led(led5_blink)
    );
  
    blink_led_B led2_blinker (
        .clk(clock_100mhz),
        .freq_div(FREQ_DIV_3HZ),
        .enable(password_B),    
        .led(led2_blink)
    );
    
    always @(*) begin
        if (password_B) begin
            led[9] = led9_blink;
            led[6] = led6_blink;
            led[5] = led5_blink;
            led[2] = led2_blink;
            led[0] = led0_blink;
            led[13] = 1'b1;
        end
    end


  always @(posedge clock_100mhz) begin
      if (password_B && !reset_done) begin
          // Reset all squares to WHITE once when password_B becomes true
          square1_color <= WHITE;
          square2_color <= WHITE;
          square3_color <= WHITE;
          reset_done <= 1;  // Mark reset as done
      end
      else if (password_B) begin
          // Update square colors based on button inputs if password_B remains true
          if (up_debounced) begin
              square1_color <= square1_color + 1;
          end
          if (centre_debounced) begin
              square2_color <= square2_color + 1;
          end
          if (down_debounced) begin
              square3_color <= square3_color + 1;
          end
      end
      else begin
          // Reset the reset_done flag when password_B is false
          reset_done <= 0;
      end
  end

  always @(posedge clock_25mhz) begin 
      if (password_B) begin
          oled_data = 16'b00000_000000_00000;  
           
          // Top square.
          if ((x_coord > 42) && (x_coord <= 52) && (y_coord >= 5) && (y_coord < 15)) begin
              case (square1_color)
                  WHITE: oled_data <= 16'b11111_111111_11111;
                  RED:   oled_data <= 16'b11111_000000_00000; 
                  GREEN: oled_data <= 16'b00000_111111_00000; 
                  BLUE:  oled_data <= 16'b00000_000000_11111; 
              endcase
          end
   
          // Middle square.
          else if ((x_coord > 42) && (x_coord <= 52) && (y_coord >= 20) && (y_coord < 30)) begin
              case (square2_color)
                  WHITE: oled_data <= 16'b11111_111111_11111; 
                  RED:   oled_data <= 16'b11111_000000_00000; 
                  GREEN: oled_data <= 16'b00000_111111_00000; 
                  BLUE:  oled_data <= 16'b00000_000000_11111;
              endcase    
          end

          // Third square.
          else if ((x_coord > 42) && (x_coord <= 52) && (y_coord >= 35) && (y_coord < 45)) begin
              case (square3_color)
                  WHITE: oled_data <= 16'b11111_111111_11111; 
                  RED:   oled_data <= 16'b11111_000000_00000; 
                  GREEN: oled_data <= 16'b00000_111111_00000; 
                  BLUE:  oled_data <= 16'b00000_000000_11111; 
              endcase  
          end

          // Fourth square.
          else if ((x_coord > 42) && (x_coord <= 52) && (y_coord >= 50) && (y_coord < 60)) begin
              if (square1_color == GREEN && square2_color == GREEN && square3_color == GREEN) begin
                  oled_data = 16'b11111_000000_00000; 
              end else begin
                  oled_data = 16'b11111_111111_11111; 
              end
          end
      end
      else begin
          oled_data = 16'b00000_000000_00000;  
      end
  end

//  Oled_Display disp_oled ( 
//        .clk(clock_6p25mhz), 
//        .reset(0),
//        .frame_begin(frame_begin), 
//        .sending_pixels(sending_pixels),
//        .sample_pixel(sample_pixel),
//        .pixel_index(pixel_index),
//        .pixel_data(oled_data),
//        .cs(JB[0]),
//        .sdin(JB[1]),
//        .sclk(JB[3]),
//        .d_cn(JB[4]),
//        .resn(JB[5]),
//        .vccen(JB[6]),
//        .pmoden(JB[7])
//    );

endmodule
