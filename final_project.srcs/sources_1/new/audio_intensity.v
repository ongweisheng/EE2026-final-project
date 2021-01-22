`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2020 22:00:00
// Design Name: 
// Module Name: audio_intensity
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


module audio_intensity(
    input clock20khz, clockseg,
    input [11:0] mic_in,
    output [15:0] led,
    output [3:0] an,
    output [7:0] seg,
    output reg [3:0] volume_level = 0
    );
    reg [12:0] count = 0;
    reg [11:0] max_volume = 0;
    always @ (posedge clock20khz) begin
        count <= (count == 5000) ? 0 : count + 1;
        max_volume <= (count == 0) ? mic_in : (mic_in > max_volume) ? mic_in : max_volume;
        volume_level <= max_volume[11] ? max_volume [10:7] : 0;
    end
    
    seg_display sd1 (clockseg, volume_level, an, seg);
    led_display ld1 (volume_level, led);
    
endmodule
