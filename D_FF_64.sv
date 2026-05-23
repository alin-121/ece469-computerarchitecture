`timescale 1ps / 1ps

module D_FF_64(in, clk, reset, out);
	input logic [63:0] in;
	input logic clk, reset;
	output logic [63:0] out;

	genvar i;
	
	generate 
		for (i = 0; i < 64; i++) begin : holdingDFF
			D_FF inst (.q(out[i]), .d(in[i]), .reset(reset), .clk(clk));
		end
	endgenerate 

endmodule

