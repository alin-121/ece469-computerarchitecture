module pc(in, clk, enable, reset, out);
	input logic [63:0] in;
	input logic clk, enable, reset;
	output logic [63:0] out;

	genvar i;
	
	generate 
		for (i = 0; i < 64; i++) begin : holdingDFF
			D_FF_new inst (.q(out[i]), .d(in[i]), .enabledff(enable), .reset(reset), .clk(clk));
		end
	endgenerate 

endmodule

