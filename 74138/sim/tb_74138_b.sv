`timescale 1ns/100ps
/*
* 74138 using IF Testbench
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/02/13  | Initial 
*/

module tb_74138_b();

// Select Inputs
    logic tb_sel_a;
    logic tb_sel_b;
    logic tb_sel_c;
// Enable Inputs
    logic tb_g1_en;
    logic tb_g2a_en;
    logic tb_g2b_en;
// Output
    logic [7:0] tb_yn;    
// Instantiates de DUT
    b_74138 DUT (
        .select_a_i (tb_sel_a),
        .select_b_i (tb_sel_b),
        .select_c_i (tb_sel_c),
        .g1_en_i    (tb_g1_en),
        .g2a_en_n_i (tb_g2a_en),
        .g2b_en_n_i (tb_g2b_en),
        .yn_o       (tb_yn)       
    );

    initial begin
    // Simulator dependent system tasks that can be used to
    // dump simulation waves        
        $dumpvars;
        $dumpfile("dump.vcd");

        $display ("[%0t] << Starting simulation >> ", $time);
        // Monitor Inputs
        $monitor("[%0t] Select A = %b, Select B = %b, Select C = %b", $time, tb_sel_a, tb_sel_b, tb_sel_c);
        $monitor("[%0t] Enable G1= %b, Enable G2A = %b, Enable G2B = %b", $time, tb_g1_en, tb_g2a_en, tb_g2b_en);
        // Monitor Outputs
        $monitor("[%0t] Output Y = %b", $time, tb_yn);
        // Initial values
        tb_sel_a  = 1'bX;
        tb_sel_b  = 1'bX;
        tb_sel_c  = 1'bX;
        tb_g1_en  = 1'bX;
        tb_g2a_en = 1'b1;
        tb_g2b_en = 1'b1;
        
        // Hold G1 enable low 
        #10 tb_g1_en = 1'b0; tb_g2a_en = 1'b0; tb_g2b_en = 1'b0; 
        #10 tb_g1_en = 1'b0; tb_g2a_en = 1'b1; tb_g2b_en = 1'b0;        
        #10 tb_g1_en = 1'b0; tb_g2a_en = 1'b0; tb_g2b_en = 1'b1;
        #10 tb_g1_en = 1'b0; tb_g2a_en = 1'b1; tb_g2b_en = 1'b1;
        
        // Hold G1 enable high
        #10 tb_g1_en = 1'b1; tb_g2a_en = 1'b0; tb_g2b_en = 1'b0; 
        #10 tb_g1_en = 1'b1; tb_g2a_en = 1'b1; tb_g2b_en = 1'b0;         
        #10 tb_g1_en = 1'b1; tb_g2a_en = 1'b0; tb_g2b_en = 1'b1; 
        #10 tb_g1_en = 1'b1; tb_g2a_en = 1'b1; tb_g2b_en = 1'b1;
        
        // Hold Enables asserted 
        #10 tb_g1_en = 1'b1; tb_g2a_en = 1'b0; tb_g2b_en = 1'b0;
 
        // Sweep select    
        tb_sel_a = 1'b0; tb_sel_b = 1'b0; tb_sel_c = 1'b0;
        #10 tb_sel_a = 1'b1; tb_sel_b = 1'b0; tb_sel_c = 1'b0;     
        #10 tb_sel_a = 1'b0; tb_sel_b = 1'b1; tb_sel_c = 1'b0;
        #10 tb_sel_a = 1'b1; tb_sel_b = 1'b1; tb_sel_c = 1'b0;
        #10 tb_sel_a = 1'b0; tb_sel_b = 1'b0; tb_sel_c = 1'b1;        
        #10 tb_sel_a = 1'b1; tb_sel_b = 1'b0; tb_sel_c = 1'b1;
        #10 tb_sel_a = 1'b0; tb_sel_b = 1'b1; tb_sel_c = 1'b1;
        #10 tb_sel_a = 1'b1; tb_sel_b = 1'b1; tb_sel_c = 1'b1;
        #10 tb_sel_a = 1'b0; tb_sel_b = 1'b0; tb_sel_c = 1'b0;
        #10 tb_g1_en = 1'b0;
        #10
        // Terminates Simulation
        $finish;
    end

endmodule