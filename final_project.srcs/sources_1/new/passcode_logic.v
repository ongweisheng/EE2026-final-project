`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2020 21:02:19
// Design Name: 
// Module Name: passcode_logic
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


module passcode_logic(
    input btnL, btnR, CLOCK,
    output password_logic
    );
    reg [2:0] count = 0;

    always @ (posedge CLOCK) begin //press btnL, btnC, btnR & btnD in order to get count to 4 to set password logic = 1;
        if (btnR)
            count <= 0;
        else
            count <= btnL ? 1 : count;
    end
   
    assign password_logic = (count == 1) ? 1 : 0; 
        
endmodule
