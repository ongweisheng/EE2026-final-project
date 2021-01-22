`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2020 23:07:24
// Design Name: 
// Module Name: debounced_spc
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


module debounced_spc(
    input pb,
    input CLOCK,
    output spo // spo = single pulse output
    );
    wire Q1, Q2;
    
    dff dff1 (CLOCK, pb, Q1);
    dff dff2 (CLOCK, Q1, Q2);
    
    assign spo = Q1 & ~Q2;
endmodule
