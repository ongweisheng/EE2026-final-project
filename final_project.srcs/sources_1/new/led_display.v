`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2020 23:37:54
// Design Name: 
// Module Name: led_display
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


module led_display(
    input [3:0] volume_level,
    output reg [15:0] led = 0
    );
    always @ (*) begin
        if (volume_level == 0)
            led = 1;
        else if (volume_level == 1) // 2 ^ volume_level - 1 to get bits 1111111 etc
            led = 3;
        else if (volume_level == 2)
            led = 7;
        else if (volume_level == 3)
            led = 15;
        else if (volume_level == 4)
            led = 31;
        else if (volume_level == 5)
            led = 63;
        else if (volume_level == 6)
            led = 127;
        else if (volume_level == 7)
            led = 255;
        else if (volume_level == 8)
            led = 511;
        else if (volume_level == 9)
            led = 1023;
        else if (volume_level == 10)
            led = 2047;
        else if (volume_level == 11)
            led = 4095;
        else if (volume_level == 12)
            led = 8191;
        else if (volume_level == 13)
            led = 16383;
        else if (volume_level == 14)
            led = 32767;
        else if (volume_level == 15)
            led = 65535;
    end
    
endmodule
