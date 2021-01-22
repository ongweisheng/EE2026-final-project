`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2020 23:19:55
// Design Name: 
// Module Name: horizontal_volume_bar
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


module horizontal_volume_bar(
    input [15:0] background_color, warning_color_top_seg, warning_color_mid_seg, warning_color_bot_seg,
    input [3:0] volume_level,
    input [6:0] x, y,
    output reg [15:0] oled_warning_bar
    );
    wire [15:0] warning_out_x_range;//
    wire warning_out_bar_y_range; // 
   
    assign warning_out_x_range[0] = 0;
    assign warning_out_x_range[1] = (volume_level > 0 && (x <= 92 && x >= 89)); // each bar lights up for 3 pixels of height. start of each bar defers by 4 pixels
    assign warning_out_x_range[2] = (volume_level > 1 && (x <= 87 && x >= 84)); // gap of 0 pixels from border if border is 2 pixels
    assign warning_out_x_range[3] = (volume_level > 2 && (x <= 82 && x >= 79));//Don't start from 64 as 4 pixel is used as border
    assign warning_out_x_range[4] = (volume_level > 3 && (x <= 77 && x >= 74));//Divide 60 pixel into 16 levels
    assign warning_out_x_range[5] = (volume_level > 4 && (x <= 72 && x >= 69));
    assign warning_out_x_range[6] = (volume_level > 5 && (x <= 67 && x >= 64));
    assign warning_out_x_range[7] = (volume_level > 6 && (x <= 62 && x >= 59));
    assign warning_out_x_range[8] = (volume_level > 7 && (x <= 57 && x >= 54));
    assign warning_out_x_range[9] = (volume_level > 8 && (x <= 52 && x >= 49));
    assign warning_out_x_range[10] = (volume_level > 9 && (x <= 47 && x >= 44));
    assign warning_out_x_range[11] = (volume_level > 10 && (x <= 42 && x >= 39));
    assign warning_out_x_range[12] = (volume_level > 11 && (x <= 37 && x >= 34));
    assign warning_out_x_range[13] = (volume_level > 12 && (x <= 32 && x >= 29));
    assign warning_out_x_range[14] = (volume_level > 13 && (x <= 27 && x >= 24));
    assign warning_out_x_range[15] = (volume_level > 14 && (x <= 22 && x >= 19));
    assign warning_out_bar_y_range = (y <= 38 && y >= 20); //None
   
    always @ (*) begin
        if (warning_out_bar_y_range && volume_level > 0 && warning_out_x_range > 0) begin // if x within range = 1, y within range = 1, and volume level not 0, trigger if loop
            if (warning_out_x_range[15:11])
                oled_warning_bar = warning_color_top_seg;
            if (warning_out_x_range[10:6])
                oled_warning_bar = warning_color_mid_seg;                                   
            if (warning_out_x_range[5:1])
                oled_warning_bar = warning_color_bot_seg;                                                                                                      
        end
        else
            oled_warning_bar = background_color; // not in any of the range = background_color
    end
    
endmodule
