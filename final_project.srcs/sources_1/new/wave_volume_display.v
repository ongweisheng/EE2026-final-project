`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2020 21:03:43
// Design Name: 
// Module Name: wave_volume_display
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


module wave_volume_display(
    input sw6, CLOCK,
    input [11:0] mic_in,
    input [6:0] x, y,
    output [15:0] oled_wave
    );
    
    reg [11:0] mic_x_pos [95:0];
    integer i;
    initial begin
        for (i = 0; i < 96; i = i + 1) begin
            mic_x_pos[i] = 0; // setting everything as 0 first for the y pos
        end
    end
    
    reg [6:0] count_x_pos = 0;
    
    always @ (posedge CLOCK) begin
        count_x_pos <= (count_x_pos == 95) ? 0 : count_x_pos + 1;
        // mic_x_pos[count_x_pos] <= sw6 ? mic_x_pos[count_x_pos] : (count_x_pos < 95) ? mic_x_pos[count_x_pos + 1] : mic_in; // difference?
        mic_x_pos[count_x_pos] <= sw6 ? mic_x_pos[count_x_pos] : mic_in;
    end
    
    wave_height wh1 (mic_x_pos[x], y, oled_wave);
             
endmodule
