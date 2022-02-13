`timescale 1ns/1ps

module 74138(
    // Select  Inputs
    input logic select_a_i,
    input logic select_b_i,
    input logic select_c_i,
    // Enable Inputs
    input logic g1_i,
    input logic g2a_n_i, // Active-low
    input logic g2b_n_i, // Active-low
    // Data Outputs
    output logic [7:0] yn_o
);

// Internal signals
logic g2_s;
logic enable;

// G2 treatment: G2 = g2a_n_i + g2b_n_i
assign g2_s = (~g2a_n_i or ~g2b_n_i);

// Enable
assign enable = ~(~g1_i) && g2_s;


endmodule