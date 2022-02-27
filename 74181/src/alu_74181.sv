/*
* 74181 4-bit logic/arithmetic ALU
* Author: Pedro Oliveira
* Date: 2022, Feb 27
*
*
*/
`timescale 1ns/100ps


module alu_74181(
    input  logic   [3:0] S_selection_i,
    input  logic         M_operation_i,
    input  logic         Carry_i,
    input  logic   [3:0] A_i,        // Active-high data inputs
    input  logic   [3:0] B_i,        // Active-high data inputs
    output logic         equality,   // A = B
    output integer [3:0] F_number_o, // Number output
    output logic         G_lookahead_o,
    output logic         P_lookahead_o;
);





endmodule
