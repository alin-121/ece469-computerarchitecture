`timescale 1ps / 1ps

module mux_64_4x1(one_one, one_zero, zero_one, zero_zero, sel, out);

    input logic [63:0] one_one;
    input logic [63:0] one_zero;
    input logic [63:0] zero_one;
    input logic [63:0] zero_zero;
    input logic [1:0] sel;
    output logic [63:0] out;
	 
    genvar i;
	 
    generate 
        for(i = 0; i < 64; i++) begin : makeMux
            mux_4x1 muxinst (.in({one_one[i], one_zero[i], zero_one[i], zero_zero[i]}), .sel(sel), .out(out[i]));
        end 
    endgenerate 

endmodule
