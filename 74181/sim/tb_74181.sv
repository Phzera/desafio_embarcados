`timescale 1ns/1ps

module tb_74181;

    logic [3:0] tb_selector;
    logic       tb_M;
    logic       tb_carry;
    logic [3:0] tb_A;
    logic [3:0] tb_A;
           
    dut alu_74181(
        .S_selection_i  (tb_selector),
        .mode_control_i (tb_M),
        .carry_in_i     (tb_carry),
        .A_i            (tb_A),
        .B_i            (tb_B)
    );
     
    initial begin
        $dumpfile("tb_74181.vcd");
        $dumpvars(0, tb_181);
    end
    
    initial begin
        #1 rst_n<=1'bx;clk<=1'bx;
        #(CLK_PERIOD*3) rst_n<=1;
        #(CLK_PERIOD*3) rst_n<=0;clk<=0;
        repeat(5) @(posedge clk);
        rst_n<=1;
        @(posedge clk);
        repeat(2) @(posedge clk);
        $finish(2);
    end
    
    endmodule
    `default_nettype wire