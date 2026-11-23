`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2026 10:15:03 AM
// Design Name: 
// Module Name: Counters
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

module Counters(
    input reset,
    input down,
    output logic [2:0] Gray_out,
    output logic [2:0] Ring_out,
    output logic [2:0] UpDn_out,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    input clk_100MHz
    );
    
    logic clk_slow; 
    clk_div T1 (clk_100MHz, clk_slow, seg, an, dp); 
    logic [2:0] Next_Gray, Next_Ring, Next_UpDn;

    // Reset
    always_ff @(posedge clk_slow, posedge reset)
        if (reset) begin
            Gray_out <= 3'b111;
            Ring_out <= 3'b001;
            UpDn_out <= 3'b000;
        end
        else begin
            Gray_out <= Next_Gray;
            Ring_out <= Next_Ring;
            UpDn_out <= Next_UpDn;
        end
        
    // Grey counter
    always_comb begin
        case (Gray_out)
            3'b000: Next_Gray = 3'b001;
            3'b001: Next_Gray = 3'b011;
            3'b010: Next_Gray = 3'b110;
            3'b011: Next_Gray = 3'b010;
            3'b100: Next_Gray = 3'b000;
            3'b101: Next_Gray = 3'b100;
            3'b110: Next_Gray = 3'b111;
            3'b111: Next_Gray = 3'b101;
        endcase

        // Ring counter
        Next_Ring = {Ring_out[1:0], Ring_out[2]};

        // Down up counter
        if (down)
            Next_UpDn = UpDn_out - 3'd1;
        else
            Next_UpDn = UpDn_out + 3'd1;
    end

endmodule