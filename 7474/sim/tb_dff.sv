/*
*  D-Flip-flop Testbench
*  Pedro Oliveira, 2022
*/
module tb_dff();

    logic clk;
    logic rstn;
    logic d;
    logic q;

    dff dut(.clk_i (clk),
            .resetn_i (rstn),
            .d_i (d),
            .q_o (q));

    always #10 clk <= ~clk;

    initial begin
        clk <= 0;
        rstn <= 1;
        d <= 0;
        q <= 0;

        #1        
        rstn <= 0;
        #10
        rstn  <= 1;

        #5  d <= 0;
        #10 d <= 1;
        #8  d <= 0;
        #3  d <= 1;
        #7  d <= 0;
    end
endmodule