`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.10.2024 20:32:09
// Design Name: 
// Module Name: debounce
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


module debounce_button (
    input wire clock_100mhz,
    input wire btn_in,
    output reg btn_out
);

    parameter DEBOUNCE_TIME = 20000000;  // 200 ms for 100 MHz clock
    parameter CHECK_PRESS_TIME = 100000; // 1 ms for 100 MHz clock

    reg [31:0] counter = 0;
    reg button_last_state = 0;
    reg [1:0] state;

    localparam IDLE = 2'b00;
    localparam CHECK_PRESS = 2'b01;
    localparam DEBOUNCE = 2'b10;
    localparam WAIT_FOR_RELEASE = 2'b11;

    initial begin
        state = IDLE;
        btn_out = 0;
    end

    always @(posedge clock_100mhz) begin
        case (state)
            // Idle state: Waiting for a button press
            IDLE: begin
                btn_out <= 0;
                counter <= 0;
                if (btn_in == 1 && button_last_state == 0) begin
                    state <= CHECK_PRESS;
                end
            end

            // Check Press: Ensure button is pressed for a short time (1 ms)
            CHECK_PRESS: begin
                if (counter < CHECK_PRESS_TIME) begin
                    counter <= counter + 1;
                    if (btn_in == 0) begin
                        state <= IDLE; // Button released early, go back to idle
                    end
                end else begin
                    state <= DEBOUNCE;
                    counter <= 0;
                end
            end

            // Debounce state: Ignore further presses for DEBOUNCE_TIME (200 ms)
            DEBOUNCE: begin
                 // Button press detected
                if (counter < DEBOUNCE_TIME) begin
                    counter <= counter + 1;
                end else begin
                    btn_out <= 1;
                    state <= WAIT_FOR_RELEASE;
                end
            end

            // Wait for Release: Ensure button is released before going back to idle
            WAIT_FOR_RELEASE: begin
                btn_out <= 0;
                if (btn_in == 0) begin
                    state <= IDLE;
                end
            end
        endcase

        button_last_state <= btn_in;
    end

endmodule





