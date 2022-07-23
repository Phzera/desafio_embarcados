`timescale 1ns/1ps
/*
* 74138 using case
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/02/13  | Initial 
*/
module c_74138(
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

logic       enable_s;
logic [2:0] select_s;

assign select_s = {select_c_i, select_b_i, select_a_i};

// Global Enable
always @(*) begin
    if(g1_en_i) begin
        if (~g2a_en_n_i && ~g2b_en_n_i) enable_s = 1'b1;
    end
    else begin
        enable_s = 1'b0;
    end
end

always @(enable_s, select_s) begin
    if (enable_s) begin
        case(select_s)
            3'b000  : yn_o = 8'b11111110;
            3'b001  : yn_o = 8'b11111101;
            3'b010  : yn_o = 8'b11111011;
            3'b011  : yn_o = 8'b11110111;
            3'b100  : yn_o = 8'b11101111;
            3'b101  : yn_o = 8'b11011111;
            3'b110  : yn_o = 8'b10111111;
            3'b111  : yn_o = 8'b01111111;
            default : yn_o = 8'b1; 
        endcase
    end else begin
        yn_o = 8'b1;
    end
end

endmodule