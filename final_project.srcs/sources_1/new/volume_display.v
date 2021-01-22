`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2020 23:25:49
// Design Name: 
// Module Name: volume_display
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


module volume_display(
    input [5:0] sw,
    input CLOCK,
    input [3:0] volume_level,
    input [6:0] x, y,
    output [15:0] oled_volume_display
    );
    wire [1:0] border_width; // 2 bit value because border either 1 pixel or 3 pixel
    wire [1:0] volume_display_color; // 2 bit value because 3 colors to change between
    wire [15:0] oled_volume_bar, oled_horizontal_volume_bar, oled_type_bar, oled_border, border_color, background_color, volume_color_top_seg, volume_color_mid_seg, volume_color_bot_seg;
    reg [4:0] freeze_volume_level = 0; 
    // border width according to switch 5 and switch 4
    assign border_width = sw[4] ? 1 : (sw[3] ? 3 : 0);
    // if switch 5 is on, border width = 1. if switch 5 is off and switch 4 is on, border width = 3. If both switch 4 and 5 off, no border
    
    always @ (posedge CLOCK) begin
        freeze_volume_level = sw[0] ? freeze_volume_level : volume_level;
    end
    
    // color chooser
    color_chooser cc1 (sw[2], sw[1], border_color, background_color, volume_color_top_seg, volume_color_mid_seg, volume_color_bot_seg);
    
    // border and background
    // border_background bb1 (border_color, background_color, x, y, border_width, oled_border);
    
    // volume bar color
    volume_bar vb1 (background_color, volume_color_top_seg, volume_color_mid_seg, volume_color_bot_seg, freeze_volume_level, x, y, oled_volume_bar);
    
    // horizontal volume bar
    horizontal_volume_bar hvb1 (background_color, volume_color_top_seg, volume_color_mid_seg, volume_color_bot_seg, freeze_volume_level, x, y, oled_horizontal_volume_bar);
    
    // choosing between normal and horizontal bar
    assign oled_type_bar = sw[5] ? oled_horizontal_volume_bar : oled_volume_bar;
    
    // border/volume/background chooser
    border_volume_background bvb1 (border_width, x, y, border_color, oled_type_bar, oled_volume_display);
    
endmodule
