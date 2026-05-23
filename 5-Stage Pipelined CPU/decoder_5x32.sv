`timescale 1ps / 1ps

module decoder_5x32(in,out,regWrite);

	input logic[4:0] in; 
	input logic regWrite;
	output logic [31:0] out;
	
	wire [7:0] temp;
	
	decoder_3x8 mainone (.in(in[4:2]), .out(temp[7:0]), .en(regWrite));
	
	decoder_2x4 first (.in(in[1:0]), .out(out[31:28]), .en(temp[7]));
	decoder_2x4 second (.in(in[1:0]), .out(out[27:24]), .en(temp[6]));
	decoder_2x4 third (.in(in[1:0]), .out(out[23:20]), .en(temp[5]));
	decoder_2x4 fourth (.in(in[1:0]), .out(out[19:16]), .en(temp[4]));
	decoder_2x4 fifth (.in(in[1:0]), .out(out[15:12]), .en(temp[3]));
	decoder_2x4 sixth (.in(in[1:0]), .out(out[11:8]), .en(temp[2]));
	decoder_2x4 seventh (.in(in[1:0]), .out(out[7:4]), .en(temp[1]));
	decoder_2x4 eighth (.in(in[1:0]), .out(out[3:0]), .en(temp[0]));
	
endmodule 

module decoder_5x32_testbench();
    logic [4:0] in;
    logic regWrite;
    logic [31:0] out;

    decoder_5x32 test (.in, .regWrite, .out);

    initial begin
        in = 5'b00000;  regWrite = 0; #1000;
        in = 5'b00000;  regWrite = 1; #1000;
        in = 5'b00001;  regWrite = 1; #1000;
        in = 5'b00010;  regWrite = 1; #1000;
        in = 5'b01010;  regWrite = 1; #1000;
        in = 5'b11111;  regWrite = 1; #1000;
        in = 5'b01111;  regWrite = 1; #1000;
        in = 5'b10000;  regWrite = 1; #1000;
        in = 5'b11000;  regWrite = 1; #1000;
    end
endmodule
