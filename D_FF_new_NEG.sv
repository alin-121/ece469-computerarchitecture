module D_FF_new_NEG(q, d, enabledff, reset, clk);

   input logic enabledff,d,clk,reset;
	output logic q;
	
	logic temp;
	logic [1:0] ins;
	
	assign ins[1] = d;
	assign ins[0] = q;
	
	mux_2x1 temps (.in(ins), .sel(enabledff), .out(temp));
	
	D_FF_NEG trick (.q(q), .d(temp), .reset(reset), .clk(clk));
	
endmodule 

module D_FF_NEG (q,d,reset,clk);
	output reg q;
	input d,reset,clk;
	
	always_ff @(negedge clk)
		if(reset)
		  q <= 0 ;
		else 
		  q <= d ;
endmodule 

		  
		  
	
