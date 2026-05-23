`timescale 1ps / 1ps

module mux_4x1(in, out,sel);

	input logic [3:0] in;
   input logic [1:0]sel;
	output logic out;
	
	wire[1:0] temps;
	
	mux_2x1 top    (.in(in[3:2]), .sel(sel[0]), .out(temps[1]));
	mux_2x1 bottom (.in(in[1:0]), .sel(sel[0]), .out(temps[0]));
	mux_2x1 finalone (.in(temps[1:0]), .sel(sel[1]), .out(out));
	
endmodule 
	
	
	
module mux_4x1_testbench();
    logic [3:0] in;
    logic [1:0] sel;
    logic out;

    mux_4x1 test (.in, .out, .sel);

    initial begin
        in = 4'b0001; sel = 2'b00; #1000;
        in = 4'b0010; sel = 2'b01; #1000;
        in = 4'b0100; sel = 2'b10; #1000;
        in = 4'b1000; sel = 2'b11; #1000;
        in = 4'b1100; sel = 2'b10; #1000;
        in = 4'b1010; sel = 2'b11; #1000;
    end
endmodule
