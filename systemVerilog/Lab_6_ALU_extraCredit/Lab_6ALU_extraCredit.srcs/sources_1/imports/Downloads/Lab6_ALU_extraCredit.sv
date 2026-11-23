`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2021 11:19:05 PM
// Design Name: 
// Module Name: Lab6_ALU
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


module Lab6_ALU(
    input logic [3:0] A,
    input logic [3:0] B,
    input logic [2:0] S,
    output logic [3:0] ALU_out
    );
    //Declare the logic signals that you are using as internal signals to interconnect the modules
    logic [3:0] XOR_out, AND_out, OR_out, ADDSUB_out, LSR_out, LSL_out, COM_out;

    XOR4 U0 (A, B, XOR_out);
    AND4 U1 (A, B, AND_out);
    OR4  U2 (A, B, OR_out);
    ADDSUB4 U3 (A, B, S[2], ADDSUB_out);

    assign LSR_out = {1'b0, A[3:1]};
    assign LSL_out = {A[2:0], 1'b0};
    assign COM_out = ~A;

    MUX4bit_8to1 U4 (S, XOR_out, AND_out, OR_out, ADDSUB_out,
                     LSR_out, LSL_out, COM_out, ADDSUB_out, ALU_out);
endmodule

module ADDSUB4(
  input logic [3:0] A,
  input logic [3:0] B,
  input logic sub,
  output logic [3:0] out
  );
  assign out = A + (B ^ {4{sub}}) + sub;
endmodule

module AND4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  assign out = A & B;
endmodule

module OR4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  assign out = A | B;
endmodule

module XOR4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  assign out = A ^ B;
endmodule

module MUX4bit_8to1(
  input logic [2:0] S,
  input logic [3:0] in0, in1, in2, in3, in4, in5, in6, in7,
  output logic [3:0] out
  );
  logic [3:0] m0, m1, m2, m3, n0, n1;

  assign m0 = S[0] ? in1 : in0;
  assign m1 = S[0] ? in3 : in2;
  assign m2 = S[0] ? in5 : in4;
  assign m3 = S[0] ? in7 : in6;
  assign n0 = S[1] ? m1 : m0;
  assign n1 = S[1] ? m3 : m2;
  assign out = S[2] ? n1 : n0;
endmodule