module debounce_sig(
    input clock_100mhz,
    input noisesig,
    output reg cleansig
);
    reg [24:0] counter = 0; 
    reg srff_1 = 0; //sr flip flop
    reg srff_2 = 0;
    reg current_sig_state = 0;
    reg prev_sig_state = 0;
    reg input_ignored = 0;

    always @(posedge clock_100mhz) begin
        // Synchronize the button signal to the clock
        srff_1 <= noisesig;
        srff_2 <= srff_1;
        prev_sig_state <= current_sig_state;

        if (input_ignored == 0) begin
            current_sig_state <= srff_2;
            if (current_sig_state == 1 && prev_sig_state == 0) begin
                cleansig <= 1;
                counter <= 25'd20000000; // 200ms at 100MHz
                input_ignored <= 1;
            end else begin
                cleansig <= 0;
            end
        end else begin
            // Debounce period
            cleansig <= 0;
            if (counter > 0) begin
                counter <= counter - 1;
            end else begin
                input_ignored <= 0;
            end
        end
    end
endmodule
