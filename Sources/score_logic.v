`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2024 05:32:35 PM
// Design Name: 
// Module Name: score_logic
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


module score_logic(
    input clock_100mhz,
    
    input is_collision,
    input game_active,
        
    output reg [7:0] seg,
    output reg [3:0] an
    );
    reg [31:0] count = 0;
    
    //use manual digit counting because % and / math cannot be done in clock
    reg [3:0] score_digit_0 = 0;
    reg [3:0] score_digit_1 = 0;
    reg [3:0] score_digit_2 = 0;
    reg [3:0] score_digit_3 = 0;
        
    always @(posedge clock_100mhz) begin
        if (game_active==1)begin
            if (is_collision == 1)begin //collision test should be done in 100mhz
                score_digit_0 <= score_digit_0;
                score_digit_1 <= score_digit_1;
                score_digit_2 <= score_digit_2;
                score_digit_3 <= score_digit_3;
                end
            else begin
                if (count == 32'd49_999_999) begin // count should increase every 0.5sec
                    count <= 0;
                    //manual digit count begin
                    if (score_digit_0 == 9) begin
                        score_digit_0 <= 0;
                        if (score_digit_1 == 9) begin
                            score_digit_1 <=0;
                            if (score_digit_2 ==9) begin
                                score_digit_2 <=0;
                                if (score_digit_3 == 9)begin
                                    score_digit_3 <= 0; //reset to zero when 9 is reached
                                    end
                                else begin
                                    score_digit_3 <= score_digit_3+1;
                                    end
                                end
                            else begin
                                score_digit_2 <= score_digit_2 +1;
                                end
                            end
                        else begin
                            score_digit_1 <= score_digit_1+1;
                            end
                        end
                    else begin
                        score_digit_0 <= score_digit_0 +1;
                        end
                    end
                    //manual digit count ends
                else begin
                    count <= count +1;
                    end
                end
            end
            
            
        else begin
            count<=0;
            score_digit_0 <= 0;
            score_digit_1 <= 0;
            score_digit_2 <= 0;
            score_digit_3 <= 0;
            end
    end
        
        
        //displaying score
    reg [1:0] nth_an_display; // 2-bit counter for selecting the display
    reg [3:0] decimal;
    reg [15:0] slow_down_clock; // Divider to slow down the clock
    //slow down nth an to display properly
    always @(posedge clock_100mhz) begin
        slow_down_clock <= slow_down_clock + 1;
        if (slow_down_clock == 0) begin
            nth_an_display <= nth_an_display + 1; // Increment slower
            end
        end
        // display each decimal
    always @(*) begin
        case (decimal)
            4'd0: seg = 8'b11000000; // "0"
            4'd1: seg = 8'b11111001; // "1"
            4'd2: seg = 8'b10100100; // "2"
            4'd3: seg = 8'b10110000; // "3"
            4'd4: seg = 8'b10011001; // "4"
            4'd5: seg = 8'b10010010; // "5"
            4'd6: seg = 8'b10000010; // "6"
            4'd7: seg = 8'b11111000; // "7"
            4'd8: seg = 8'b10000000; // "8"
            4'd9: seg = 8'b10010000; // "9"
            default : seg = 8'b11111111;
        endcase
    end

    //display each digit
    always @(posedge clock_100mhz) begin
        case (nth_an_display)
            2'b00: begin
            an = 4'b1110;
                decimal = score_digit_0;
            end
            2'b01: begin
                an = 4'b1101;
                decimal = score_digit_1;
            end
            2'b10: begin
                an = 4'b1011;
                decimal = score_digit_2;
            end
            2'b11: begin
                an = 4'b0111;
                decimal = score_digit_3;
            end      
            endcase
        end
endmodule
