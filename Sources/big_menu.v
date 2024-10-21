`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2024 09:07:00 PM
// Design Name: 
// Module Name: big_menu
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


module big_menu(
input clock_100mhz,
    input btnC, btnU, btnD,
    input wire [12:0] pixel_index,
    output reg  [15:0] oled_data_menu,
    output reg start_game = 0
    );
    
    reg [2:0] state = 3'b000;
     wire [2:0] stateout [0:5];
       //instantiate homepage
    wire [15:0] oled_data_home;
    wire[2:0] home_state;
    wire [2:0] home_stateout;
    home_page homepage(.clock_100mhz(clock_100mhz), .btnC(btnC), .btnU(btnU), .btnD(btnD), .pixel_index_home(pixel_index), .oled_data_home(oled_data_home),
    .home_state(state), .home_stateout(home_stateout)
    );
    
    //instantiate select mode
    wire [15:0] oled_data_select;
  //  wire[2:0] select_state;
    wire [2:0] select_stateout;
     select_mode chooseamode(.clock_100mhz(clock_100mhz),.btnU(btnU), .btnD(btnD),.pixel_index_select(pixel_index), .oled_data_select(oled_data_select),
     .home_stateout(state), .select_stateout(select_stateout)
     );
     
     //instantiate stage difficulty selection
     wire [15:0] oled_data_stagediff;
     wire [2:0] stage_diff_stateout;
     stage_select_difficulty stagediff(.clock_100mhz(clock_100mhz), .btnU(btnU), .btnD(btnD), .pixel_index_stagediff(pixel_index),.oled_data_stagediff(oled_data_stagediff),
     .select_stateout(state), .stage_diff_stateout(stage_diff_stateout)
     );
     
         localparam WHITE = 16'b1111111111111111;
     reg btnC_selected;
     reg btnC_pressed;
     reg step = 0;
     always @(posedge clock_100mhz) begin
    case(step)
         0: begin
             if (btnC && home_stateout == 3'b001) begin
                 state <= 3'b001;
                 step <= 1;
             end
             else if (btnC && home_stateout == 3'b010) begin
                 state <= 3'b010;
             end
         end
         1: begin
             if (btnC && select_stateout == 3'b011) begin
                 state <= 3'b011;
                 start_game <= 1;
             end
             else if (btnC && select_stateout == 3'b100) begin
                 state <= 3'b100;
             end
         end
         default: state <= 3'b000;
     endcase
            
//         if (btnC && home_stateout==3'b001) begin
//             state <= 3'b001; //select 'START' to go select
//         end

//         else if (btnC && home_stateout==3'b010) begin //select 'COLOR'
//             state<=3'b010;
//         end
//             if (btnC && select_stateout==3'b011) begin //select 'stage' 
//  state <=3'b011;
//  start_game<=1;
//end
//else if (btnC && select_stateout==3'b100) begin // select 'endless'
//  state<=3'b100;
//end
//         else  begin
//         state <=state; 
        
//         end
          
        if (state==3'b000) begin
             oled_data_menu <= oled_data_home;
        end
        else if (state==3'b001) begin
                  oled_data_menu <= oled_data_select;
              end
        else if (state==3'b011) begin
             oled_data_menu <=oled_data_stagediff;
             end
         else begin
             oled_data_menu<=oled_data_stagediff;
             end
     end
endmodule
