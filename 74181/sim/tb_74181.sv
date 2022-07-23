/*
* 74181 4-bit logic/arithmetic ALU Testbench
* Author: Pedro Oliveira
* Date: 2022, Jul 23
* Active-High Inputs/Outputs
*/
`timescale 1ns/1ps

module tb_74181;

    logic [3:0] tb_selector;
    logic       tb_M;
    logic       tb_carry;
    logic [3:0] tb_A;
    logic [3:0] tb_B;
    logic       clk;
           
    alu_74181 dut(
        .S_selection_i  (tb_selector),
        .mode_control_i (tb_M),
        .carry_in_i     (tb_carry),
        .A_i            (tb_A),
        .B_i            (tb_B)
    );

    // 74181 Typical delay: 22 ns   
    localparam CLK_PERIOD = 22;
    always #(CLK_PERIOD/2) clk=~clk;
    
    // Randomize inputs Selector, A and B
    initial begin
        $dumpvars;
        $dumpfile("tb_74181.vcd");
    end
    
    int i, j; //iterator
    initial begin

        #1 clk<=1'bx;
        #(CLK_PERIOD*3) clk<=0;
        tb_M <= 1'b1;
        tb_selector <= 1'b0;
        
        // Stimulus Logic operation
        for (i = 0; i < 16; i = i++) begin
            //rand_input.randomize.();
            tb_selector = tb_selector + i;
            //$display("Iteration = %0d, S = %0h, A = %0h, B = %0h", i, 
            //             rand_input.s, rand_input.a, rand_input.b);
            $display("Iteration = %0d, S = %0h", i, tb_selector);
            //for (j = 0; )
        end

        #(CLK_PERIOD*3);
        tb_M <= 1'b0;

       repeat(2) @(posedge clk);

      $finish(1);
    end
    
    endmodule
    `default_nettype wire