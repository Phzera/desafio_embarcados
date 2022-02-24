`timescale 1ns/1ps
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
always @(*) begin
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
        if (select_c_i) begin
            if (select_b_i) begin
                if (select_a_i) begin
                    yn_o[7] = 1'b0;
                end else begin
                    yn_o[6] = 1'b0;
                end
            end else begin
                if (select_a_i) begin
                    yn_o[5] = 1'b0;
                end else begin
                    yn_o[4] = 1'b0;
                end
            end
        end else begin
            if (select_b_i) begin
                if (select_a_i) begin
                    yn_o[3] = 1'b0;
                end else begin
                    yn_o[2] = 1'b0;
                end
            end else begin
                if (select_a_i) begin
                    yn_o[1] = 1'b0;
                end else begin
                    yn_o[0] = 1'b0;
                end
            end
        end
    end else begin
        yn_o = 8'b1;
    end
end


endmodule