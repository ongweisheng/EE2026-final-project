`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2020 18:42:47
// Design Name: 
// Module Name: wave_height
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


module wave_height(
    input [11:0] mic_in,
    input [6:0] y,
    output [15:0] oled_wave
    );
    
    reg [5:0] y_level;
    wire [6:0] y_pos_flipped;
    reg red, yellow, green;
    assign y_pos_flipped = 63 - y; // start from bottom of oled screen instead of from the top
    always @ (*) begin
        y_level = mic_in[11] ? mic_in[10:5] : 0;
        if (y_pos_flipped < y_level) begin
            red = (y_level >= 42);
            yellow = (y_level >= 21 && y_level <= 41);
            green = (y_level >= 0 && y_level <= 20);
        end
        else begin
            red = 0;
            yellow = 0;
            green = 0;
        end
    end
    
    assign oled_wave = green ? 16'b00000_111111_00000 : yellow ? 16'b11111_111111_00000 : red ? 16'b11111_000000_00000 : 16'b00000_000000_00000;
    // within green range, oled green, yellow range, oled yellow, red range, oled red, if not background black
endmodule
