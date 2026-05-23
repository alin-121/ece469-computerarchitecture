`timescale 1ps / 1ps

module D_FF_32(in, clk, enable,reset, out);
    input  logic [31:0] in;
    input  logic        clk, enable,reset;
    output logic [31:0] out;

    genvar i;
    generate 
        for (i = 0; i < 32; i++) begin : holdingDFF
            D_FF_new inst (.q(out[i]), .d(in[i]), .enabledff(enable), .reset(reset), .clk(clk));
        end
    endgenerate 
endmodule
