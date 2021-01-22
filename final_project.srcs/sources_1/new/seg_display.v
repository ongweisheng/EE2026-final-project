`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2020 22:47:09
// Design Name: 
// Module Name: seg_display
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


module seg_display(
    input clockseg,
    input [3:0] volume_level,
    output reg [3:0] an = 4'b1111,
    output reg [7:0] seg = 8'b11111111
    );

    reg [7:0] ones_place, tens_place, safety_letters;
    reg [2:0] count = 0;
    
    always @ (*) begin
        tens_place = volume_level > 9 ? 8'b11111001 : 8'b11000000; // digit 1 if > 9 else digit 0
        safety_letters = volume_level > 10 ? 8'b10001001 : volume_level > 5 ? 8'b11111001 : 8'b11000111; // H, I, L according to volume_level
        if (volume_level == 0 || volume_level == 10)
            ones_place = 8'b11000000; // digit 0
        else if (volume_level == 1 || volume_level == 11)
            ones_place = 8'b11111001; // digit 1
        else if (volume_level == 2 || volume_level == 12)
            ones_place = 8'b10100100;
        else if (volume_level == 3 || volume_level == 13)
            ones_place = 8'b10110000;
        else if (volume_level == 4 || volume_level == 14)
            ones_place = 8'b10011001;
        else if (volume_level == 5 || volume_level == 15)
            ones_place = 8'b10010010;
        else if (volume_level == 6 || volume_level == 16)
            ones_place = 8'b10000010;
        else if (volume_level == 7)
            ones_place = 8'b11111000;
        else if (volume_level == 8)
            ones_place = 8'b10000000;
        else if (volume_level == 9)
            ones_place = 8'b10010000;
    end
    
    always @ (posedge clockseg) begin//Make the 7 segment loop at an fast pace
        count <= count + 1;
        if (count == 0) begin
            an <= 4'b0111;
            seg <= safety_letters;
        end
        else if (count == 0) begin
            an <= 4'b1111;
            seg <= 8'b11111111;
        end
        else if (count == 2) begin
             an <= 4'b1110;
             seg <= ones_place;
        end
        else if (count == 3) begin
            an <= 4'b1101;
            seg <= tens_place;
        end
    end
        
endmodule
