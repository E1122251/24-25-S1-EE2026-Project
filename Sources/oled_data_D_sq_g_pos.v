`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 22:44:39
// Design Name: 
// Module Name: oled_data_D_sq_g_pos
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


module oled_data_D_sq_g_pos(
    
    input clock_100mhz,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    input password_D,
    
    input [6:0] sq_big_left,
    input [5:0] sq_big_top,
    input [6:0] sq_big_right,
    input [5:0] sq_big_bot,
    
    output reg [6:0] sq_g_left = 7'd3,
    output reg [5:0] sq_g_top = 6'd3,
    
    output wire [6:0] sq_g_right,
    output wire [5:0] sq_g_bot,
    
    output reg sq_g_moving = 1'b0
    
    );
    
    assign sq_g_right = sq_g_left + 7'd6;
    assign sq_g_bot = sq_g_top + 6'd6;
    
    reg [2:0] sq_g_dir = 3'd0;
    
    // sq_g_contact begin
    
    wire sq_g_contact_U; wire sq_g_contact_R; wire sq_g_contact_D; wire sq_g_contact_L;
    
    assign sq_g_contact_U = ( sq_g_top   == 6'd0  ) || ( ( sq_g_top   == sq_big_bot + 1   ) && ( sq_g_right >= sq_big_left ) && ( sq_g_left <= sq_big_right ) );
    
    assign sq_g_contact_D = ( sq_g_bot   == 6'd63 ) || ( ( sq_g_bot   == sq_big_top - 1   ) && ( sq_g_right >= sq_big_left ) && ( sq_g_left <= sq_big_right ) );
    
    assign sq_g_contact_L = ( sq_g_left  == 7'd0  ) || ( ( sq_g_left  == sq_big_right + 1 ) && ( sq_g_bot   >= sq_big_top  ) && ( sq_g_top  <= sq_big_bot )   );
    
    assign sq_g_contact_R = ( sq_g_right == 7'd95 ) || ( ( sq_g_right == sq_big_left - 1  ) && ( sq_g_bot   >= sq_big_top  ) && ( sq_g_top  <= sq_big_bot )   );
    
    // sq_g_contact end
    
    wire clock_20hz;
    
    clock_variable_gen clock_20hz_gen ( .clock_100mhz(clock_100mhz), .m(32'd2499999), .clock_output(clock_20hz) );
    
    // always block to assign sq_g_dir begin
    
    wire [4:0] btn = {btnC, btnU, btnR, btnD, btnL};
    
    always @(posedge clock_100mhz) begin
        
        if ( password_D ) begin
            
            if ( btn == 5'b01000 ) begin
                
                sq_g_dir <= 3'd1;
                
            end else if ( btn == 5'b00100 ) begin
                
                sq_g_dir <= 3'd2;
                
            end else if ( btn == 5'b00010 ) begin
                
                sq_g_dir <= 3'd3;
                
            end else if ( btn == 5'b00001 ) begin
                
                sq_g_dir <= 3'd4;
                
            end else if ( btn == 5'b00000 ) begin
                
                sq_g_dir <= sq_g_dir;
                
            end else begin
                
                sq_g_dir <= 3'd0;
                
            end
            
        end else begin
            
            sq_g_dir <= 3'd0;
            
        end
        
    end
    
    // always block to assign sq_g_dir end
    
    // always block to move sq_g begin
    
    always @(posedge clock_20hz) begin
        
        if ( password_D ) begin
        
            if ( sq_g_dir == 3'd0 ) begin
                
                sq_g_moving <= 0;
                
            end else if ( sq_g_dir == 3'd1 ) begin
                
                if ( sq_g_contact_U == 1 ) begin
                    
                    sq_g_moving <= 0;
                    
                end else begin
                    
                    sq_g_top <= sq_g_top - 1;
                    
                    sq_g_moving <= 1;
                    
                end
                
            end else if ( sq_g_dir == 3'd2 ) begin
                
                if ( sq_g_contact_R == 1 ) begin
                
                    sq_g_moving <= 0;
                
                end else begin
                
                    sq_g_left <= sq_g_left + 1;
                    
                    sq_g_moving <= 1;
                
                end
                            
            end else if ( sq_g_dir == 3'd3 ) begin
                        
                if ( sq_g_contact_D == 1 ) begin
                
                    sq_g_moving <= 0;
                
                end else begin
                
                    sq_g_top <= sq_g_top + 1;
                    
                    sq_g_moving <= 1;
                
                end
                                    
            end else if ( sq_g_dir == 3'd4 ) begin
                        
                if ( sq_g_contact_L == 1 ) begin
            
                    sq_g_moving <= 0;
            
                end else begin
            
                    sq_g_left <= sq_g_left - 1;
                    
                    sq_g_moving <= 1;
            
                end
                
            end
            
        end else begin
            
        sq_g_left <= 7'd3;
        sq_g_top <= 6'd3;
            
        end
        
    end
    
    // always block to move sq_g end
    
endmodule
