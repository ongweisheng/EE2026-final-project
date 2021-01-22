`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    input CLOCK,
    input [15:0] sw,
    output [15:0] led,
    output [7:0] seg, JC,
    output [3:0] an,
    input btnU, btnL, btnC, btnR, btnD
    );
    // Clocks
    wire clock6p25mhz, clock50hz, clock20khz, clock1hz, clockseg;
    
    // Buttons
    wire reset, pulseL, pulseC, pulseR, pulseD; // reset = btnU
    
    // Oled wires/ related stuff
    wire frame_begin, sending_pixels, sample_pixel;
    wire [4:0] teststate;
    wire [12:0] pixel_index;
    wire [6:0] x, y;
    wire [15:0] oled_data;
    // assign JC[2] = 0;
    
    // Audio related wires
    wire [11:0] mic_in;
    wire [3:0] volume_level;
    wire [3:0] an_intensity;
    wire [7:0] seg_intensity;
    wire [15:0] led_intensity;
    
    //Oled display wires
    wire [15:0] oled_volume_display;
    wire [15:0] oled_wave;
    wire [15:0] oled_lockscreen;
    wire [15:0] oled_menu;
    wire menu_state;
    wire [1:0] overall_state;
    
    // logic and states
    wire password_logic;
       
    // Other created modules wires
    
    // Clocks instantiation
    clock_divider clock_1 (CLOCK, 7, clock6p25mhz);
    clock_divider clock_2 (CLOCK, 999999, clock50hz);
    clock_divider clock_3 (CLOCK, 2499, clock20khz);
    clock_divider clock_4 (CLOCK, 50000000, clock1hz);
    clock_divider clock_5 (CLOCK, 65616, clockseg);
    
    // Buttons instantiation
    debounced_spc dspc_1 (btnU, clock6p25mhz, reset); // same frequency as required for the oled display
    debounced_spc dspc_2 (btnL, clock50hz, pulseL);
    debounced_spc dspc_3 (btnC, clock50hz, pulseC);
//    debounced_spc dspc_4 (btnR, clock50hz, pulseR);
    debounced_spc dspc_5 (btnD, clock50hz, pulseD);
    
    // Audio capture instantiation
    Audio_Capture AC1 (CLOCK, clock20khz, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in);
    
    // Oled instantiation and converting pixel_index into X & Y coordinates
    Oled_Display oled1 (clock6p25mhz, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, oled_data, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], teststate);
    convert_to_X_Y X_Y (pixel_index, x, y);
    
    // Audio intensity
    audio_intensity ai1 (clock20khz, clockseg, mic_in, led_intensity, an_intensity, seg_intensity, volume_level);
    
    // Oled volume display //clock speed undecided
    volume_display vd1 (sw[5:0], clock20khz, volume_level, x, y, oled_volume_display);
    
    // wave volume display
    wave_volume_display wvd1 (sw[6], clock20khz, mic_in, x, y, oled_wave);
    
    //passcode logic
    passcode_logic pl1 (btnL, btnR, clock50hz, password_logic);
    
    //Oled lockscreen
    lockscreen_display ld1 (x, y, password_logic, oled_lockscreen);
    
    // Oled menu
    menu_display md1 (clock50hz, pulseD, x, y, oled_menu, menu_state);
    
    // state chooser
    state_chooser sc1 (clock50hz, btnL, btnC, btnR, password_logic, menu_state, overall_state);
    
    // choosing output
    function_chooser fc1 (CLOCK, overall_state, oled_lockscreen, oled_menu, oled_volume_display, oled_wave, led_intensity, an_intensity, seg_intensity, oled_data, led, an, seg);
    // Delete this comment and write your codes and instantiations here
    
endmodule