`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 23:03:15
// Design Name: 
// Module Name: clocks_player_gen
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


module clocks_player_gen(
    
    input clock_100mhz,
    
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    
    output clock_5hz_vsync,
    output clock_10hz_vsync,
    output clock_15hz_vsync,
    output clock_20hz_vsync,
    output clock_25hz_vsync,
    output clock_30hz_vsync
    
    );
    
    // clocks begin
    
    wire clock_5hz; wire clock_10hz; wire clock_15hz; wire clock_20hz; wire clock_25hz; wire clock_30hz;
    
    clock_variable_gen clock_5hz_gen  ( .clock_100mhz(clock_100mhz), .m(32'd9_999_999), .clock_output(clock_5hz)  );
    clock_variable_gen clock_10hz_gen ( .clock_100mhz(clock_100mhz), .m(32'd4_499_999), .clock_output(clock_10hz) );
    clock_variable_gen clock_15hz_gen ( .clock_100mhz(clock_100mhz), .m(32'd3_333_332), .clock_output(clock_15hz) );
    clock_variable_gen clock_20hz_gen ( .clock_100mhz(clock_100mhz), .m(32'd2_499_999), .clock_output(clock_20hz) );
    clock_variable_gen clock_25hz_gen ( .clock_100mhz(clock_100mhz), .m(32'd1_999_999), .clock_output(clock_25hz) );
    clock_variable_gen clock_30hz_gen ( .clock_100mhz(clock_100mhz), .m(32'd1_666_666), .clock_output(clock_30hz) );
    
    // clocks end
    
    
    // vsync begin
    
    vsync vsync_clock_5hz  ( .clock_100mhz(clock_100mhz), .pixel_x(pixel_x), .pixel_y(pixel_y), .clock(clock_5hz),  .clock_vsync(clock_5hz_vsync)  );
    vsync vsync_clock_10hz ( .clock_100mhz(clock_100mhz), .pixel_x(pixel_x), .pixel_y(pixel_y), .clock(clock_10hz), .clock_vsync(clock_10hz_vsync) );
    vsync vsync_clock_15hz ( .clock_100mhz(clock_100mhz), .pixel_x(pixel_x), .pixel_y(pixel_y), .clock(clock_15hz), .clock_vsync(clock_15hz_vsync) );
    vsync vsync_clock_20hz ( .clock_100mhz(clock_100mhz), .pixel_x(pixel_x), .pixel_y(pixel_y), .clock(clock_20hz), .clock_vsync(clock_20hz_vsync) );
    vsync vsync_clock_25hz ( .clock_100mhz(clock_100mhz), .pixel_x(pixel_x), .pixel_y(pixel_y), .clock(clock_25hz), .clock_vsync(clock_25hz_vsync) );
    vsync vsync_clock_30hz ( .clock_100mhz(clock_100mhz), .pixel_x(pixel_x), .pixel_y(pixel_y), .clock(clock_30hz), .clock_vsync(clock_30hz_vsync) );
    
    // vsync end
    
endmodule
