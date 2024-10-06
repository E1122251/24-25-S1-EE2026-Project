`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2024 10:59:41 PM
// Design Name: 
// Module Name: student_A
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


module student_A(
    input clock_100mhz,
    input password_A,
    input [12:0] pixel_index_A,
    input btnU, btnC, 
    output reg [15:0] oled_data_A,
    output [15:0] led_A);
    
    //led password
    wire clock_9hz;
    clock_9hz P0(
    .clock_100mhz(clock_100mhz),
    .clock_9hz(clock_9hz)
    );
        
    assign led_A[0] = clock_9hz;
    assign led_A[2] = clock_9hz;
    assign led_A[3] = clock_9hz;
    assign led_A[7] = clock_9hz;
    assign led_A[8] = clock_9hz;
    assign led_A[9] = clock_9hz;    
    assign led_A[12] = 1;
    
    assign led_A[1] = 0;
    assign led_A[4] = 0;
    assign led_A[5] = 0;
    assign led_A[6] = 0;
    assign led_A[10] = 0;
    assign led_A[11] = 0;
    assign led_A[13] = 0;
    assign led_A[14] = 0;
    assign led_A[15] = 0;
    
    wire DBbtnU;
    wire DBbtnC;
    
    debounce_sig p1 (
    .clock_100mhz(clock_100mhz),
    .noisesig(btnU),
    .cleansig(DBbtnU));

    debounce_sig p2 (
    .clock_100mhz(clock_100mhz),
    .noisesig(btnC),
    .cleansig(DBbtnC));
    
    reg ring_activated = 0;
    reg shapes_activated = 0;
    reg [2:0] count = 3'b000;
    
    //xy coordinate
    wire [6:0] x = pixel_index_A % 96;
    wire [5:0] y = pixel_index_A / 96;
    
    //for circle
    wire signed [8:0] dx = $signed({1'b0,x})-47; //x-center 47
    wire signed [8:0] dy = $signed({1'b0,y})-31; //y-center 31
    wire [16:0] square_dx = dx*dx;
    wire [16:0] square_dy = dy*dy;    
    wire [16:0] square_distance = square_dx + square_dy;
    
    always @ (posedge clock_100mhz) begin
        if (password_A == 1) begin
            if (((x>=3 && x <=5 ) || (x>=90 && x<=92)) && (y>=3 && y <= 60)) begin // 4.a1right and left
                oled_data_A <= 16'hF800;
            end
            else if (((y>=3 && y<=5) || (y>=58 && y <=60)) && (x >=3 && x <= 92)) begin // 4.a1top and bottom
                oled_data_A <= 16'hF800;
            end
            else begin
                oled_data_A <= 16'h0000;
            end
                        
            if (DBbtnU==1) begin
                ring_activated <= 1;
            end
                
            if (DBbtnC==1) begin //4.a2
                if (shapes_activated == 0) begin
                    shapes_activated <= 1;
                    count <= 3'b000;
                end
                else begin
                    if (count == 3'b101) begin
                        count <= 3'b000;
                    end
                    else begin
                        count <= count +1;
                    end
                end
            end
                
            if (ring_activated == 1) begin
                if (shapes_activated ==1) begin
                    if ((count==3'b000 || count==3'b001 || count==3'b010) 
                        && (square_distance >= 289 && square_distance <= 400)) 
                        begin //orange ring 
                            oled_data_A <= 16'hFD20;
                        end
                    else if ((count==3'b011 || count==3'b100 || count==3'b101)
                        && (square_distance >= 289 && square_distance <= 400)) 
                        begin //white ring
                            oled_data_A <= 16'hFFFF;
                        end
                    end
                else begin
                    if (square_distance >= 289 && square_distance <= 400) begin //if shapes are not activated ring is orange
                        oled_data_A <= 16'hFD20;
                    end
                end
            end
                   
            if (shapes_activated==1) begin //4.a3
                if (count == 3'b000 && square_distance <= 81) begin
                        oled_data_A <= 16'h07E0;
                    end
                if (count == 3'b000 && square_distance <= 81) begin
                    oled_data_A <= 16'h07E0; // Green solid circle
                    end 
                else if (count == 3'b001 && square_distance <= 81) begin
                    oled_data_A <= 16'hFD20; // Orange solid circle
                    end 
                else if (count == 3'b010 && square_distance <= 81) begin
                    oled_data_A <= 16'hF800; // Red solid circle
                    end 
                else if (count == 3'b011 && (x >= 43 && x <= 51) && (y >= 27 && y <= 35)) begin
                    oled_data_A <= 16'h07E0; // Green solid square
                    end 
                else if (count == 3'b100 && (x >= 43 && x <= 51) && (y >= 27 && y <= 35)) begin
                    oled_data_A <= 16'hFD20; // Orange solid square
                    end 
                else if (count == 3'b101 && (x >= 43 && x <= 51) && (y >= 27 && y <= 35)) begin
                    oled_data_A <= 16'hF800; // Red solid square
                end                              
            end
        end     
        else begin
            shapes_activated <= 0 ;
            ring_activated <=  0;
            count <= 0;
        end
    end
endmodule
