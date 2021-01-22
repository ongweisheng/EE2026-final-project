`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2020 22:53:28
// Design Name: 
// Module Name: convert_to_X_Y
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


module convert_to_X_Y(
    input [12:0] pixel_index,
    output [6:0] x, y
    );
    assign x = pixel_index % 96; // 96 x 64 resolution of oled display
    assign y = pixel_index / 96;
endmodule
