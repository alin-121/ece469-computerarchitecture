`timescale 1ps / 1ps

module mux_2x1(in, out,sel);
	input logic [1:0] in;
   input logic sel;
	output logic out;
	
	wire[1:0] temp;
	wire zeroCheck;
	
	not #50 zeros(zeroCheck, sel);
	and #50 onein(temp[1], sel,in[1]);
	and #50 zeroin(temp[0], zeroCheck,in[0]);
	or  #50 finalor(out, temp[1],temp[0]);

endmodule 

module mux_2x1_testbench();
    logic [1:0] in;
    logic sel;
	 logic out;
	 
	 mux_2x1 test (.in,.out,.sel);
	 
	 initial begin 
	                         sel = 0; #1000;
	 
		in[1] = 1; in[0] = 0;          #1000;
		           in[0] = 1;          #1000;
		in[1] = 0; in[0] = 1; sel = 1; #1000;
		           in[1] = 1;          #1000;
								             #1000;
    end 
endmodule
  

	
	