`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2020 01:27:56
// Design Name: 
// Module Name: color_chooser
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


module color_chooser(
    input sw2, sw1,
    output reg [15:0] border_color, background_color, volume_color_top_seg, volume_color_mid_seg, volume_color_bot_seg
    );
    
    always @ (*) begin
        if (sw2 && ~sw1) begin // 1st color, sw2 = 1, sw1 = 0
            // type colors here
            border_color = 16'b11111_111111_00000; // yellow;
            background_color = 16'b11111_111111_11111; // white
            volume_color_top_seg = 16'b11111_000000_00000; // red
            volume_color_mid_seg = 16'b11111_100110_00000; // orange = red + lesser of green
            volume_color_bot_seg = 16'b00000_111111_00000; // green
        end
        else if (~sw2 && sw1) begin // 2nd color, sw2 = 0, sw1 = 1
            // type colors here
            border_color = 16'b11111_100110_00000; // orange = red + lesser of green
            background_color = 16'b01100_011000_01100; // grey = lesser of all colors
            volume_color_top_seg = 16'b11111_000000_11111; // magenta = red + blue
            volume_color_mid_seg = 16'b11111_111111_00000; // yellow = red + green
            volume_color_bot_seg = 16'b00000_111111_11111; // cyan = green + blue
        end
        else if (~sw2 && ~sw1) begin // original color, sw2 = 0, sw1 = 0
            // type colors here
            border_color = 16'b11111_111111_11111; // white
            background_color = 16'b00000_000000_00000; // black
            volume_color_top_seg = 16'b11111_000000_00000; // red
            volume_color_mid_seg = 16'b11111_111111_00000; // yellow = red + green
            volume_color_bot_seg = 16'b00000_111111_00000; // green
        end
        else begin // show border only but not volume bar
            // type colors here
            border_color = 16'b1111111111111111; // white
            background_color = 16'b0000000000000000; // black
            volume_color_top_seg = 16'b0000000000000000; // black
            volume_color_mid_seg = 16'b0000000000000000; // black
            volume_color_bot_seg = 16'b0000000000000000; // black
        end
    end
            
endmodule
