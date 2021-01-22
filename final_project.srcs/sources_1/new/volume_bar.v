`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2020 15:40:52
// Design Name: 
// Module Name: volume_bar
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


module volume_bar(
    input [15:0] background_color, volume_color_top_seg, volume_color_mid_seg, volume_color_bot_seg,
    input [3:0] volume_level,
    input [6:0] x, y,
    output reg [15:0] oled_volume_bar
    );
    wire volume_bar_x_range;
    wire [15:0] volume_bar_y_range; // 16 levels of volume and don't need to list 1 by 1 in if else statements later
    assign volume_bar_x_range = x >= 39 && x <= 56;
    assign volume_bar_y_range[0] = 0;
    assign volume_bar_y_range[1] = (volume_level > 0 && (y <= 60 && y >= 58)); // each bar lights up for 3 pixels of height. start of each bar defers by 4 pixels
    assign volume_bar_y_range[2] = (volume_level > 1 && (y <= 56 && y >= 54)); // gap of 0 pixels from border if border is 3 pixels
    assign volume_bar_y_range[3] = (volume_level > 2 && (y <= 52 && y >= 50));
    assign volume_bar_y_range[4] = (volume_level > 3 && (y <= 48 && y >= 46));
    assign volume_bar_y_range[5] = (volume_level > 4 && (y <= 44 && y >= 42));
    assign volume_bar_y_range[6] = (volume_level > 5 && (y <= 40 && y >= 38));
    assign volume_bar_y_range[7] = (volume_level > 6 && (y <= 36 && y >= 34));
    assign volume_bar_y_range[8] = (volume_level > 7 && (y <= 32 && y >= 30));
    assign volume_bar_y_range[9] = (volume_level > 8 && (y <= 28 && y >= 26));
    assign volume_bar_y_range[10] = (volume_level > 9 && (y <= 24 && y >= 22));
    assign volume_bar_y_range[11] = (volume_level > 10 && (y <= 20 && y >= 18));
    assign volume_bar_y_range[12] = (volume_level > 11 && (y <= 16 && y >= 14));
    assign volume_bar_y_range[13] = (volume_level > 12 && (y <= 12 && y >= 10));
    assign volume_bar_y_range[14] = (volume_level > 13 && (y <= 8 && y >= 6));
    assign volume_bar_y_range[15] = (volume_level > 14 && (y <= 4 && y >= 2));
    
    always @ (*) begin
        if (volume_bar_x_range && volume_level > 0 && volume_bar_y_range > 0) begin // if x within range = 1, y within range = 1, and volume level not 0, trigger if loop
            if (volume_bar_y_range[15:11])
                oled_volume_bar = volume_color_top_seg;
            if (volume_bar_y_range[10:6])
                oled_volume_bar = volume_color_mid_seg;                                   
            if (volume_bar_y_range[5:1])
                oled_volume_bar = volume_color_bot_seg;                                                                                                      
        end
        else
            oled_volume_bar = background_color; // not in any of the range = background_color
    end
    
                    
endmodule
