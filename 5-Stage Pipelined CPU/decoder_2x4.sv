`timescale 1ps / 1ps

module decoder_2x4(in, out, en);
   
	input logic[1:0] in; 
	input logic en;
	output logic [3:0] out;
	
	
	wire [1:0] temp;
	
	decoder_1x2 mainone (.in(in[1]), .out(temp[1:0]), .en(en));
	
	decoder_1x2 up (.in(in[0]), .out(out[3:2]), .en(temp[1]));
	decoder_1x2 down (.in(in[0]), .out(out[1:0]), .en(temp[0]));
	
	
endmodule 

module decoder_2x4_testbench();
    logic [1:0] in;
    logic en;
    logic [3:0] out;

    decoder_2x4 test (.in, .en, .out);

    initial begin
        in = 2'b00; en = 0; #1000;
        in = 2'b00; en = 1; #1000;
        in = 2'b01; en = 1; #1000;
        in = 2'b10; en = 1; #1000;
        in = 2'b11; en = 1; #1000;
    end
endmodule
