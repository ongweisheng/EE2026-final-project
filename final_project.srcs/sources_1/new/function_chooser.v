`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2020 21:03:02
// Design Name: 
// Module Name: function_chooser
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


module function_chooser(
    input CLOCK,
    input [1:0] overall_state,
    input [15:0] oled_lockscreen, oled_menu, oled_volume_display, oled_wave, led_intensity,
    input [3:0] an_intensity,
    input [7:0] seg_intensity,
    output reg [15:0] oled_data, led,
    output reg [3:0] an,
    output reg [7:0] seg 
    );
    
    always @ (posedge CLOCK) begin
        if (overall_state == 3) begin
            oled_data = oled_lockscreen;
            led = 0;
            an = 4'b1111;
            seg = 8'b11111111;
        end
        else if (overall_state == 2) begin
            oled_data = oled_menu;
            led = 0;
            an = 4'b1111;
            seg = 8'b11111111;
        end
        else if (overall_state == 1) begin
            oled_data = oled_wave;
            led = led_intensity;
            an = an_intensity;
            seg = seg_intensity;
        end
        else if (overall_state == 0) begin
            oled_data = oled_volume_display;
            led = led_intensity;
            an = an_intensity;
            seg = seg_intensity;
        end
    end
           
endmodule
