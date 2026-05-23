`timescale 1ps / 1ps

module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);
	
	input logic [63:0] A,B;
	input logic [2:0] cntrl;
	output logic negative,zero,overflow,carry_out;
	
	output logic [63:0] result;
	
	logic [63:0] couttrack;
	
	alu_1bit lsb (.A(A[0]), .B(B[0]), .cntrl, .result(result[0]), .carry_out(couttrack[0]), .carry_in(cntrl[0]));
	alu_1bit msb (.A(A[63]), .B(B[63]), .cntrl, .result(result[63]), .carry_out(couttrack[63]), .carry_in(couttrack[62]));
	
	genvar i;
	
	generate 
		for(i=1;i<63;i++) begin: alubus
			alu_1bit osb (.A(A[i]), .B(B[i]), .cntrl, .result(result[i]), .carry_out(couttrack[i]), .carry_in(couttrack[i-1]));
		end 
	endgenerate 
	
	zeroFlag zerocheck (.result, .zero);
	
	assign negative = result[63];
	assign carry_out = couttrack[63];
	
	xor #50 over(overflow,couttrack[63],couttrack[62]);
endmodule 
 
	

	
	