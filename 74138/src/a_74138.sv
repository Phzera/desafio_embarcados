`timescale 1ns/100ps
/*
* 74138 using logic operators
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/02/13  | Initial 
*/
module a_74138(
    // Select  Inputs
    input logic select_a_i,
    input logic select_b_i,
    input logic select_c_i,
    // Enable Inputs
    input logic g1_en_i,    // Active-high
    input logic g2a_en_n_i, // Active-low
    input logic g2b_en_n_i, // Active-low
    // Data Outputs
    output logic [7:0] yn_o
);

logic enable_s;

// Global Enable
assign enable_s = ~g2a_en_n_i && ~g2b_en_n_i && g1_en_i;

// Combinatorial Outputs
assign yn_o[0] = ~(~select_a_i && ~select_b_i  && ~select_c_i && enable_s);
assign yn_o[1] = ~(select_a_i  && ~select_b_i  && ~select_c_i && enable_s);
assign yn_o[2] = ~(~select_a_i &&  select_b_i  && ~select_c_i && enable_s);
assign yn_o[3] = ~(select_a_i  &&  select_b_i  && ~select_c_i && enable_s);
assign yn_o[4] = ~(~select_a_i && ~select_b_i  &&  select_c_i && enable_s);
assign yn_o[5] = ~(select_a_i  && ~select_b_i  &&  select_c_i && enable_s);
assign yn_o[6] = ~(~select_a_i &&  select_b_i  &&  select_c_i && enable_s);
assign yn_o[7] = ~(select_a_i  &&  select_b_i  &&  select_c_i && enable_s);

endmodule