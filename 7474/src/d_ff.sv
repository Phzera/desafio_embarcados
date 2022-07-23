/*
*  D-Flip-flop 
*  Pedro Oliveira, 2022
*/

module d_ff(
    input  logic clk_i,
    input  logic resetn_i,
    input  logic d_i,
    output logic q_o
);

always_ff @(posedge clk_i or negedge resetn_i) begin
    if(~resetn_i) begin
        q_o <= 0;
    end
    else begin
        q_o <= d;
    end
end

endmodule