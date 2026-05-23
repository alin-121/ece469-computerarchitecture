`timescale 1ps / 1ps

module D_FF_new(q, d, enabledff, reset, clk);

   input logic enabledff,d,clk,reset;
	output logic q;
	
	logic temp;
	logic [1:0] ins;
	
	assign ins[1] = d;
	assign ins[0] = q;
	
	mux_2x1 temps (.in(ins), .sel(enabledff), .out(temp));
	
	D_FF trick (.q(q), .d(temp), .reset(reset), .clk(clk));
	
endmodule 