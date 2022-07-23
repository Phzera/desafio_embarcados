/*
* 74181 4-bit logic/arithmetic ALU
* Author: Pedro Oliveira
* Date: 2022, Feb 27
* Active-High Inputs/Outputs
*
*/
`timescale 1ns/100ps


module alu_74181(
    input  logic [3:0]  S_selection_i,     // Operator selector
    input  logic        mode_control_i,    // M mode control input
    input  logic        carry_in_i,        // Carry In
    input  logic [3:0]  A_i,               // Active-high data inputs
    input  logic [3:0]  B_i,               // Active-high data inputs
    output logic        equality_o,        // A = B
    output signed [3:0] F_o,               // Number output
    output logic        carry_output_o,    // Carry in + 4
    output logic        generated_carry_o, // G and P are not affected by carry in
    output logic        propagated_carry_o;
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
            4'b0000: F_o = carry_in_i ? (A_i + 4'b1) : A_i;
            4'b0001: F_o = carry_in_i ? ((A_i | B_i) + 4'b1) : (A_i | B_i);
            4'b0010: F_o = carry_in_i ? ((A_i | ~B_i) + 4'b1) : (A_i | ~B_i);
            4'b0011: F_o = carry_in_i ? 4'b0 : 4'sb1001; // Signed output
            4'b0100: F_o = carry_in_i ? (A_i + (A_i & ~B_i) + 4'b1) : (A_i + (A_i & B_i));
            4'b0101: F_o = carry_in_i ? ((A_i | B_i) + (A_i & ~B_i) + 4'b1) : ((A_i | B_i) + (A_i & ~B_i));
            4'b0110: F_o = carry_in_i ? (A_i - B_i) : (A_i - B_i - 4'b1);
            4'b0111: F_o = carry_in_i ? (A_i & ~B_i) : (A_i & ~B_i) - 4'b1;
            4'b1000: F_o = carry_in_i ? (A_i + (A_i & B_i) + 4'b1) : (A_i + B_i);
            4'b1001: F_o = carry_in_i ? (A_i + B_i + 4'b1) : (A_i + B_i);
            4'b1010: F_o = carry_in_i ? ((A_i + ~B_i) + (A_i & B_i) + 4'b1) : ((A_i | ~B_i) + (A_i & B_i));
            4'b1011: F_o = carry_in_i ? A_i & B_i : (A_i & B_i) - 4'b1;
            4'b1100: F_o = carry_in_i ? (A_i + A_i + 4'b1) : (A_i + A_i);
            4'b1101: F_o = carry_in_i ? ((A_i | B_i) + A_i + 4'b1) : (A_i | B_i) + A_i;
            4'b1110: F_o = carry_in_i ? ((A_i | ~B_i) + A_i + 4'b1) : (A_i | ~B_i) + A_i;
            4'b1111: F_o = carry_in_i ? A_i : A_i - 4'b1; 
            default: F_o = 4'bX;
        endcase
    end
end

// A = B -> AND between F outputs
assign equality_o = &F_o;

// G lookahead

// P lookahead

// Cn+4 

endmodule
