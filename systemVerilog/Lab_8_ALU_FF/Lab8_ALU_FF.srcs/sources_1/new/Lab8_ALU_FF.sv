`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 10:51:54 AM
// Design Name: 
// Module Name: Lab8_ALU_FF
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


module Lab8_ALU_FF(
    input[3:0] A,
    input[3:0] B,
    output logic [3:0] ALU_OUT_FF,
    input [1:0] S,
    input clk_100MHz,
    output[6:0] seg,
    output [3:0] an,
    output dp
    );
    logic clk_slow;
    logic [3:0] ALU_out;
    
    Lab6_ALU I0 (A, B, S, ALU_out);
    clk_div T1 (clk_100MHz, clk_slow, seg, an, dp);
    always_ff @(negedge clk_slow)
    ALU_OUT_FF <= ALU_out;
    
endmodule