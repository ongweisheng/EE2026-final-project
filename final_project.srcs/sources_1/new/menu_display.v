`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2020 18:23:12
// Design Name: 
// Module Name: menu_display
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


module menu_display(
    input CLOCK, btnD,
    input [6:0] x, y,
    output [15:0] oled_menu,
    output reg state = 0
    );
    
    wire menu_length;
    wire [6:0] menuX;
    wire v, o, l, u, e, b, a, a1, r, w, Wa, Wa1, Wa2, Wv, We, E;
    wire menu, volume_bar, wave;
    
    wire boxwidth, box1, box2;
    wire [15:0] menu_display [2:0];
    
    // Assign range
    assign menu_length = (y >= 3 && y <= 16);
    assign menuX[0] = (x == 26 || x == 27);
    assign menuX[1] = (x == 38 || x == 39);
    assign menuX[2] = (x == 42 || x == 43);
    assign menuX[3] = (x == 52 || x == 53);
    assign menuX[4] = (x == 60 || x == 61);
    assign menuX[5] = (x == 64 || x == 65);
    assign menuX[6] = (x == 70 || x == 71);
    assign E = (x >= 44 && x <= 49);
   
    // ranges for volume bar
    assign v = (y >= 22 && y <= 26);
    assign o = (y >= 23 && y <= 27);
    assign l = (y >= 22 && y <= 28);
    assign u = (y >= 22 && y <= 27);
    assign e = (x >= 40 && x <= 42);
    assign b = (x >= 47 && x <= 49);
    assign a = (y >= 25 && y <= 28);
    assign a1 = (x >= 52 && x <= 54);
    assign r = (x >= 58 && x <= 60);
   
    // ranges for wave
    assign w = (y >= 42 && y <= 47);
    assign Wa = (y >= 45 && y <= 48);
    assign Wa1 = (x >= 21 && x <= 23);
    assign Wa2 = (y >= 42 && y <= 48);
    assign Wv = (y >= 42 && y <= 46);
    assign We = (x >= 33 && x <= 35);
    
    // menu
    assign menu = ((menuX[4:0] && menu_length) // Straight lines for 7 pixels M, E, N
                    || ((x == 28 && (y == 5 || y == 6)) || (x == 29 && (y == 6 || y == 7)) || (x == 30 && (y == 7 || y == 8)) || (x == 31 && (y == 8 || y == 9)) || ((x == 32 || x == 33) && (y == 9 || y == 10)))
                    || (x == 34 && (y == 8 || y == 9)) || (x == 35 && (y == 7 || y == 8)) || (x == 36 && (y == 6 || y == 7)) || (x == 37 && (y == 5 || y == 6)) // M
                    || (E && (y == 3 || y == 4 || y == 9 || y == 10 || y == 15 || y == 16)) // E
                    || ((x == 53 && (y == 6 || y == 7)) || (x == 54 && (y == 7 || y == 8)) || (x == 55 && (y == 8 || y == 9)) || (x == 56 && (y == 9 || y == 10)) || (x == 57 && (y == 10 || y == 11)) || (x == 58 && (y == 11 || y == 12))) // N
                    || ((menuX[6:5] && (y >= 3 && y <= 14)) || ((x >= 66 && x <= 69) && (y == 15 || y == 16)))); // U
    // volume_bar
    assign volume_bar = ((v && (x == 12 || x == 16)) || (x == 13 && y == 27) || (x == 14 && y == 28) || (x == 15 && y == 27) //v
                        || (o && (x == 18 || x == 22) || ((y == 22 || y == 28) && (x == 19 || x == 20 || x == 21))) // o
                        || ((l && x == 24) || ((x == 25 || x == 26 || x == 27) && y == 28)) // l
                        || ((u && (x == 29 || x == 32)) || ((x == 30 || x == 31) && y == 28)) // u
                        || ((l && (x == 34 || x == 38)) || (y == 23 && (x == 35 || x == 37)) || (y == 24 && x == 36)) // m
                        || ((l && x == 40) || (e && (y == 22 || y == 25 || y == 28))) // e
                        || ((l && x == 47) || (b && (y == 22 || y == 25 || y == 28)) || (x == 50 && (y == 23 || y == 24 || y == 26 || y == 27))) // b
                        || ((x == 56 && l) || (x == 52 && a) || (a1 && y == 26) || (x == 55 && y == 22) || (x == 54 && y == 23) || (x == 53 && y == 24)) // a
                        || ((x == 58 && l) || ((y == 25 || y == 22) && r) || ((y == 23 || y == 24) && x == 61) || (x == 60 && y == 26) || (x == 61 && y == 27) || (x == 62 && y == 28))); //r
    // wave
    assign wave = ((w && (x == 12 || x == 15 || x == 18)) || ((x == 13 || x == 14 || x == 16 || x == 17) && y == 48) // w
                    || ((x == 24 && Wa2) || (x == 20 && Wa) || (Wa1 && y == 45) || (x == 23 && y == 42) || (x == 22 && y == 43) || (x == 21 && y == 44)) // a
                    || ((Wv && (x == 26 || x == 30)) || (x == 27 && y == 47) || (x == 28 && y == 48) || (x == 29 && y == 47)) // v
                    || (Wa2 && x == 32) || (We && (y == 42 || y == 45 || y == 48))); // e 
                    
    // selecting
    assign boxwidth = (x >= 0 && x <= 95);
    assign box1 = (y >= 21 && y <= 29) && boxwidth && ~volume_bar;
    assign box2 = (y >= 41 && y <= 49) && boxwidth && ~wave;
   
    assign menu_display[0] = (menu || box1 || wave);
    assign menu_display[1] = (menu || volume_bar || box2);
     
    always @ (posedge CLOCK) begin
        state <= btnD ? ~state : state;
    end
   
    assign oled_menu = menu_display[state] ? 16'b11111_000000_00000 : 16'b11111_111111_11111; // red if not white backgroun
   
endmodule

