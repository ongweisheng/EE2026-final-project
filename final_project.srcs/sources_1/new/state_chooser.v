`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2020 22:06:07
// Design Name: 
// Module Name: state_chooser
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


module state_chooser(
    input CLOCK, btnL, btnC, btnR, password_logic, menu_state,
    output reg [1:0] overall_state = 3
    );
    // 3 = lockscreen, 2 = menu
    always @ (posedge CLOCK) begin
        if ((overall_state == 3 && password_logic) || ((overall_state != 3 && overall_state != 2) && btnR))
            overall_state <= 2;
        else if (overall_state == 2 && btnC)
            overall_state <= menu_state;
        else if (overall_state == 2 && btnR)
            overall_state <= 3;
        else if (overall_state == menu_state && btnL)
            overall_state <= 2;
        else
            overall_state <= overall_state;
    end
        
endmodule
