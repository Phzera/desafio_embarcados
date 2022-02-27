/*
* 74181 4-bit logic/arithmetic ALU
* Author: Pedro Oliveira
* Date: 2022, Feb 27
*
*
*/
`timescale 1ns/100ps


module alu_74181(
    input  logic [3:0]  S_selection_i,
    input  logic        mode_control_i,
    input  logic        carry_in_i,
    input  logic [3:0]  A_i,        // Active-high data inputs
    input  logic [3:0]  B_i,        // Active-high data inputs
    output logic        equality_o,   // A = B
    output signed [3:0] F_o,         // Number output
    output logic        carry_plus_four_o,
    output logic        G_lookahead_o,
    output logic        P_lookahead_o;
);

always @(*) begin
    if (mode_control_i) begin // M = High: Perform Logic Operations
        case(S_selection_i) begin
            4'b0000: F_o = ~A_i;
            4'b0001: F_o = ~(A_i | B_i);
            4'b0010: F_o = ~A_i & B_i;
            4'b0011: F_o = 4'b0;
            4'b0100: F_o = ~(A_i & B_i);
            4'b0101: F_o = ~B_i;
            4'b0110: F_o = A_i ^ B_i;
            4'b0111: F_o = A_i & ~B_i;
            4'b1000: F_o = (~A_i & B_i);
            4'b1001: F_o = ~(A_i ^ B_i);
            4'b1010: F_o = B_i;
            4'b1011: F_o = A_i & B_i;
            4'b1100: F_o = 4'b1;
            4'b1101: F_o = A_i | ~B_i;
            4'b1110: F_o = A_i | B_i;
            4'b1111: F_o = A_i;
            default: F_o = 4'bX;
        endcase
    end else begin // M = Low: Perform Arithmetic Operations
        case(S_selection_i) begin
            4'b0000: F_o = carry_in_i ? (A_i + 1'b1) : A_i;
            4'b0001: F_o = carry_in_i ? ((A_i | B_i) + 1'b1) : (A_i | B_i);
            4'b0010: F_o = carry_in_i ? ((A_i | ~B_i) + 1'b1) : (A_i | ~B_i);
            4'b0011: F_o = carry_in_i ? 4'b0 : 4'sb1001;
            4'b0100: F_o = carry_in_i ? (A_i + (A_i & ~B_i) + 1'b1) : (A_i + (A_i & B_i));
            4'b0101: F_o = carry_in_i ? ((A_i | B_i) + (A_i & ~B_i) + 1'b1) : ((A_i | B_i) + (A_i & ~B_i));
            4'b0110: F_o = carry_in_i ? (A_i - B_i) : (A_i - B_i - 1'b1);
            4'b0111: F_o = carry_in_i ? (A_i & ~B_i) : (A_i & ~B_i) - 1'b1;
            4'b1000: F_o = carry_in_i ? (A_i + (A_i & B_i) + 1'b1) : (A_i + B_i);
            4'b1001: F_o = carry_in_i ? (A_i + B_i + 1'b1) : (A_i + B_i);
            4'b1010: F_o = carry_in_i ? ((A_i + ~B_i) + (A_i & B_i) + 1'b1) : ((A_i | ~B_i) + (A_i & B_i));
            4'b1011: F_o = carry_in_i ? A_i & B_i : (A_i & B_i) - 1'b1;
            4'b1100: F_o = carry_in_i ? (A_i + A_i + 1'b1) : (A_i + A_i);
            4'b1101: F_o = carry_in_i ? ((A_i | B_i) + A_i + 1'b1) : (A_i | B_i) + A_i;
            4'b1110: F_o = carry_in_i ? ((A_i | ~B_i) + A_i + 1'b1) : (A_i | ~B_i) + A_i;
            4'b1111: F_o = carry_in_i ? A_i : A_i - 1'b1; 
            default: F_o = 4'bX;
        endcase
    end
end



endmodule
