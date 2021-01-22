`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2020 18:17:29
// Design Name: 
// Module Name: border_volume_background
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


module border_volume_background(
    input [1:0] border_width,
    input [6:0] x, y,
    input [15:0] border_color, oled_volume_bar,
    output [15:0] oled_volume_display
    );
    assign oled_volume_display = (border_width && (x < border_width || x > 95 - border_width || y < border_width  || y > 63 - border_width)) ? border_color : oled_volume_bar;
    //
endmodule
