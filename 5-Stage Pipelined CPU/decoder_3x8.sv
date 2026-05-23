`timescale 1ps / 1ps

module decoder_3x8(in,out,en);

	input logic[2:0] in; 
	input logic en;
	output logic [7:0] out;
	
	wire [1:0] temp;
	
	decoder_1x2 mainone (.in(in[2]), .out(temp[1:0]), .en(en));
	
	decoder_2x4 up (.in(in[1:0]), .out(out[7:4]), .en(temp[1]));
	decoder_2x4 down (.in(in[1:0]), .out(out[3:0]), .en(temp[0]));
	
endmodule 

module decoder_3x8_testbench();
    logic [2:0] in;
    logic en;
    logic [7:0] out;

    decoder_3x8 test (.in, .en, .out);

    initial begin
        in = 3'b000; en = 0; #1000;
        in = 3'b000; en = 1; #1000;
        in = 3'b001; en = 1; #1000;
        in = 3'b010; en = 1; #1000;
        in = 3'b011; en = 1; #1000;
        in = 3'b100; en = 1; #1000;
        in = 3'b101; en = 1; #1000;
        in = 3'b110; en = 1; #1000;
        in = 3'b111; en = 1; #1000;
        in = 3'b111; en = 0; #1000;
    end
	 
endmodule
