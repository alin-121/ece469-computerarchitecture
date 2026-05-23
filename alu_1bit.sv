// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B 
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant
`timescale 1ps / 1ps

module alu_1bit(A, B, cntrl, result, carry_out, carry_in);

	input logic  A,B,carry_in;
	input logic [2:0] cntrl;
	
	output logic result,carry_out;
	
	logic [7:0] muxinput;
	logic [1:0] lilmuxinput;
	
	logic faMuxInput, faOut;
	
	assign lilmuxinput[0] = B; 
	not #50 rand2 (lilmuxinput[1],B);
	
	assign muxinput[0] = B;     // 000
	assign muxinput[2] = faOut; // 010
	assign muxinput[3] = faOut; // 011
	
	and #50 cntrl100 (muxinput[4],B,A);
	or  #50 cntrl101 (muxinput[5],B,A);
	xor #50 cntrl110 (muxinput[6],B,A);
	
	// dont cares
	assign muxinput[1] = A; // 001
	assign muxinput[7] = A; // 111
	
	
	
	mux_2x1 fa (.in(lilmuxinput), .out(faMuxInput),.sel(cntrl[0]));
	
	fullAdder_1bit addorsub (.A(A),.B(faMuxInput),.Cin(carry_in),.Cout(carry_out),.sum(faOut));

   mux_8x1 outputToBus (.in(muxinput), .out(result), .sel(cntrl));

endmodule
	

module alu_1bit_testbench();
    logic A, B, carry_in;
    logic [2:0] cntrl;
    logic result, carry_out;

    alu_1bit dut (.A(A), .B(B), .cntrl(cntrl), .result(result), .carry_out(carry_out), .carry_in(carry_in));

    initial begin
        A = 0; B = 0; carry_in = 0;  
        cntrl = 3'b000; #10000;
        cntrl = 3'b010; #10000;
        cntrl = 3'b011; #10000;
        cntrl = 3'b100; #10000;
        cntrl = 3'b101; #10000;
        cntrl = 3'b110; #10000;

        A = 1; B = 0; carry_in = 0; 
        cntrl = 3'b000; #10000;
        cntrl = 3'b010; #10000;
        cntrl = 3'b011; #10000;
        cntrl = 3'b100; #10000;
        cntrl = 3'b101; #10000;
        cntrl = 3'b110; #10000;

        A = 1; B = 1; carry_in = 0; 
        cntrl = 3'b000; #10000;
        cntrl = 3'b010; #10000;
        cntrl = 3'b011; #10000;
        cntrl = 3'b100; #10000;
        cntrl = 3'b101; #10000;
        cntrl = 3'b110; #10000;

        A = 1; B = 1; carry_in = 1; 
        cntrl = 3'b010; #10000;
        cntrl = 3'b011; #10000;
    end
endmodule 
   