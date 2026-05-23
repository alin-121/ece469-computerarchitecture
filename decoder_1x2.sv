`timescale 1ps / 1ps

module decoder_1x2(in, out, en);

	input logic in, en;
	output logic [1:0] out;
	
	wire zerotrack;
	
	not #50 zerocheck (zerotrack, in);
	and #50 up (out[1], en, in);
	and #50 down (out[0], zerotrack,en);
	
endmodule 

module decoder_1x2_testbench();
    logic in, en;
    logic [1:0] out;

    decoder_1x2 test (.in, .en, .out);

    initial begin
        in = 0; en = 0; #1000;
        in = 1; en = 0; #1000;
        in = 0; en = 1; #1000;
        in = 1; en = 1; #1000;
        
    end
endmodule
