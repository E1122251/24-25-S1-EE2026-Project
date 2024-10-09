`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: Kim Joohyung
//  STUDENT B NAME: Aryan Dubey
//  STUDENT C NAME: 
//  STUDENT D NAME: Lam Zhe Yu Isaac
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    
    input clock_100mhz,
    
    input [15:0] sw,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    output reg [15:0] led,
    
    output wire [7:0] JB
    
    );
    
    // define passwords begin
    
    wire password_A;
    wire password_B;
    wire password_C;
    wire password_D;
    
    assign password_A = ( sw == 16'b0001_0011_1000_1101 );
    assign password_B = ( sw == 16'b0010_0010_0110_0101 );
    // assign password_C = 
    assign password_D = ( sw == 16'b1000_0001_1001_0101 );
    
    // define passwords end
    
    // instantiate Oled_Display begin
    
    wire clock_6p25mhz;
    
    clock_variable_gen clock_6p25mhz_gen ( .clock_100mhz(clock_100mhz), .m(32'd7), .clock_output(clock_6p25mhz) );
    
    wire frame_begin;
    wire sending_pixels;
    wire sample_pixel;
    wire [12:0] pixel_index;
    
    reg [15:0] oled_data;
    
    Oled_Display disp_oled ( 
          
        .clk(clock_6p25mhz), 
        .reset(0),
          
        .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel),
        
        .pixel_index(pixel_index),
          
        .pixel_data(oled_data),
          
        .cs(JB[0]),
        .sdin(JB[1]),
        .sclk(JB[3]),
        .d_cn(JB[4]),
        .resn(JB[5]),
        .vccen(JB[6]),
        .pmoden(JB[7])
          
        );    
    
    assign JB[2] = 1'b0;
    
    // instantiate Oled_Display end
    
    // instantiate oled_data_init_gen begin
    
    wire [15:0] oled_data_init;
    
    oled_data_init_gen oled_data_init_gen_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .pixel_index(pixel_index),
        
        .oled_data_init(oled_data_init)
            
        );
    
    // instantiate oled_data_init_gen end
    
    // instantiate student_A begin
    
    wire [15:0] led_A;
    wire [15:0] oled_data_A;
    
    student_A student_A_instance (
             
        .clock_100mhz(clock_100mhz),
        
        .btnU(btnU),
        .btnC(btnC),
        
        .pixel_index_A(pixel_index),
        
        .password_A(password_A),
        
        .led_A(led_A),
        
        .oled_data_A(oled_data_A)
             
        );
    
    // instantiate student_A end
    
    // instantiate student_B begin
    
    wire [15:0] led_B;
    wire [15:0] oled_data_B;
    
    student_B student_B_instance (
             
        .clock_100mhz(clock_100mhz),
             
        .btnC(btnC),
        .btnU(btnU),
        .btnD(btnD),
             
        .pixel_index(pixel_index),
             
        .password_B(password_B),
             
        .led(led_B),
             
        .oled_data(oled_data_B)
        
        );
    
    // instantiate student_B end
    
    // instantiate student_C begin
    
    wire [15:0] led_C;
    wire [15:0] oled_data_C;
    
    // instantiate student_C end
    
    // instantiate student_D begin
    
    wire [15:0] led_D; 
    wire [15:0] oled_data_D;
    
    student_D student_D_instance (
        
        .clock_100mhz(clock_100mhz),
        
        .btnC(btnC),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        
        .pixel_index(pixel_index),
        
        .password_D(password_D),
        
        .led_D(led_D),
        
        .oled_data_D(oled_data_D)
        
        );
    
    // instantiate student_D end

    student_E student_E_instance ();
    
    // always block to assign led and oled_data begin
    
    always @(posedge clock_100mhz) begin
        
        if ( password_A ) begin
            
            led <= led_A;
            
            oled_data <= oled_data_A;
            
        end else if ( password_B ) begin
            
            led <= led_B;
            
            oled_data <= oled_data_B;
            
        end else if ( password_C ) begin
            
            led <= led_C;
            
            oled_data <= oled_data_C;
            
        end else if ( password_D ) begin
            
            led <= led_D;
            
            oled_data <= oled_data_D;
            
        end else begin
            
            led <= sw;
            
            oled_data <= oled_data_init;
            
        end
        
    end
    
    // always block to assign led and oled_data end
    
    endmodule
    
