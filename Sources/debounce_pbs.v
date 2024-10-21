`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2024 17:23:43
// Design Name: 
// Module Name: debounce_pbs
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


module debounce_pbs(
    
    input clock_100mhz,
    
    input btnC, btnU, btnL, btnR, btnD,
    
    output btnC_db, btnU_db, btnL_db, btnR_db, btnD_db
    
    );
    
    debounce debounce_btnC ( .clock_100mhz(clock_100mhz), .signal(btnC), .signal_debounced(btnC_db) );
    debounce debounce_btnU ( .clock_100mhz(clock_100mhz), .signal(btnU), .signal_debounced(btnU_db) );
    debounce debounce_btnL ( .clock_100mhz(clock_100mhz), .signal(btnL), .signal_debounced(btnL_db) );
    debounce debounce_btnR ( .clock_100mhz(clock_100mhz), .signal(btnR), .signal_debounced(btnR_db) );
    debounce debounce_btnD ( .clock_100mhz(clock_100mhz), .signal(btnD), .signal_debounced(btnD_db) );
        
endmodule
