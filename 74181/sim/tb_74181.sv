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
           
    dut alu_74181(
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
    class Inputs;
        randc  logic [3:0] s;
        randc logic [3:0] a;
        randc logic [3:0] b;
    endclass
    
    assign tb_A        = rand_input.a;
    assign tb_B        = rand_input.b;
    assign tb_selector = rand_input.s;

    initial begin
        $dumpfile("tb_74181.vcd");
        $dumpvars(0, tb_181);
    end
    
    initial begin

        #1 clk<=1'bx;
        #(CLK_PERIOD*3) clk<=0;

        Inputs rand_input = new();
        for (int i = 0; i < 16; i++) begin
            rand_input.randomize.();
            $display("Iteration= %0d, S= %0h, A = %0h, B = %0h", i, 
                        rand_input.s, rand_input.a, rand_input.b);
        end
        
       repeat(2) @(posedge clk);

        $finish(2);
    end
    
    endmodule
    `default_nettype wire