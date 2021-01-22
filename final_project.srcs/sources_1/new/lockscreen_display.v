`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2020 21:18:28
// Design Name: 
// Module Name: lockscreen_display
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


module lockscreen_display(
    input [12:0] x, y,
    input password_logic,
    output [15:0] oled_lockscreen
    );
    wire within_x_y_range, height0, height1, height2, E_1, E_2, TWO_3, ZERO_4, TWO_5, SIX_6, SIX_6_EMPTY;
    // assign range
    assign height0 = (y >= 16 && y <= 47); // for every letter
    assign height1 = (y >= 18 && y <= 30); // for the twos and six
    assign height2 = (y >= 33 && y <= 45); // for the twos and six
    assign E_1 = (x >= 3 && x <= 15); // for letter 1st E
    assign E_2 = (x >= 18 && x <= 30); // for letter 2nd E
    assign TWO_3 = (x >= 33 && x <= 45); // for letter first 2
    assign ZERO_4 = (x >= 48 && x <= 60); // for letter 0
    assign TWO_5 = (x >= 63 && x <= 75); // for letter second 2
    assign SIX_6 = (x >= 78 && x <= 90); // for letter six
    assign SIX_6_EMPTY = (x == 89|| x == 90) && (y >= 33 && y <= 46); // line on the right side of SIX digit
    
    assign within_x_y_range = (((height0 && (x == 3 || x == 4)) || (E_1 && (y == 16 || y == 17 || y == 31 || y == 32 || y == 46 || y == 47 ))) // 1st E
                                || ((height0 && (x == 18 || x == 19)) || (E_2 && (y == 16 || y == 17 || y == 31 || y == 32 || y == 46 || y == 47))) // 2nd E
                                || ((height1 && (x == 44 || x == 45)) || (height2 && (x == 33 || x == 34)) || (TWO_3 && (y == 16 || y == 17 || y == 31 || y == 32 || y == 46 || y == 47))) // 1st 2
                                || ((height0 && (x == 48 || x == 49 || x == 59 || x == 60)) || (ZERO_4 & (y == 16 || y == 17 || y == 46 || y == 47))) // 0   
                                || ((height1 && (x == 74 || x == 75)) || (height2 && (x == 63 || x == 64)) || (TWO_5 && (y == 16 || y == 17 || y == 31 || y == 32 || y == 46 || y == 47))) // 2nd 2
                                || ((height0 && (x == 79 || x == 80)) || (SIX_6 && (y == 16 || y == 17 || y == 31 || y == 32 || y == 46 || y == 47)) || SIX_6_EMPTY)); // 6
    
    assign oled_lockscreen = within_x_y_range ? 16'b11111_000000_00000 : 16'b11111_111111_11111; // if within range red, else background is white                            
    
endmodule
