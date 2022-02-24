`timescale 1ns/100ps
/*
* 74138 using always @ () IF
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/02/13  | Initial 
*/
module b_74138(
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
always @(g1_en_i, g2a_en_n_i, g2b_en_n_i) begin
    if(g1_en_i) begin
        if (~g2a_en_n_i && ~g2b_en_n_i) begin
            enable_s = 1'b1;
        end else begin
            enable_s = 1'b0;
        end
    end else begin
        enable_s = 1'b0;
    end
end

always @(*) begin
    if (enable_s) begin
        if (select_c_i && select_b_i && select_a_i) begin
            yn_o = 8'b01111111;
        end
        else if (select_c_i && select_b_i && ~select_a_i) begin
            yn_o = 8'b10111111;
        end
        else if (select_c_i && ~select_b_i && select_a_i) begin
            yn_o = 8'b11011111;
        end
        else if (select_c_i && ~select_b_i && ~select_a_i) begin
            yn_o = 8'b11101111;
        end
        else if (~select_c_i && select_b_i && select_a_i) begin
            yn_o = 8'b11110111;
        end
        else if (~select_c_i && select_b_i && ~select_a_i) begin
            yn_o = 8'b11111011;
        end
        else if (~select_c_i && ~select_b_i && select_a_i) begin
            yn_o = 8'b11111101;
        end 
        else if  (~select_c_i && ~select_b_i && ~select_a_i) begin
            yn_o = 8'b11111110;
        end else 
            yn_o = 8'b1;
        end
    end
endmodule