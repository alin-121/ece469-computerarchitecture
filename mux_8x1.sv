`timescale 1ps / 1ps

module mux_8x1(in, out,sel);

	input logic [7:0] in;
   input logic [2:0]sel;
	output logic out;
	
	wire[1:0] temps;
	
	mux_4x1 top    (.in(in[7:4]), .sel(sel[1:0]), .out(temps[1]));
	mux_4x1 bottom (.in(in[3:0]), .sel(sel[1:0]), .out(temps[0]));
	mux_2x1 finalone (.in(temps[1:0]), .sel(sel[2]), .out(out));
	
endmodule 

module mux_8x1_testbench();
    logic [7:0] in;
    logic [2:0] sel;
    logic out;

    mux_8x1 test (.in, .out, .sel);

    initial begin
        in = 8'b00000001; sel = 3'b000; #1000;
        in = 8'b00000010; sel = 3'b001; #1000;
        in = 8'b00000100; sel = 3'b010; #1000;
        in = 8'b00001000; sel = 3'b011; #1000;
        in = 8'b00010000; sel = 3'b100; #1000;
        in = 8'b00100000; sel = 3'b101; #1000;
        in = 8'b01000000; sel = 3'b110; #1000;
        in = 8'b10000000; sel = 3'b111; #1000;
		  in = 8'b10000000; sel = 3'b000; #1000;
		  
    end
endmodule
