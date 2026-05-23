`timescale 1ps / 1ps

module fullAdder_1bit(A,B,Cin,Cout,sum);

	input logic A,B,Cin;
	output logic Cout,sum;
	
	logic firstxor;
	logic firstand;
	logic secondand;
	
	xor #50 some  (firstxor, A,B);
	and #50 some2 (firstand, A,B);
	and #50 some3 (secondand, firstxor, Cin);
	xor #50 some4 (sum, Cin, firstxor);
	or  #50 some5 (Cout, secondand, firstand);
	
	
endmodule 

module fullAdder_1bit_testbench();
    logic A, B, Cin;
    logic sum, Cout;

    fullAdder_1bit dut (.A(A), .B(B), .Cin(Cin), .sum(sum), .Cout(Cout));

    initial begin
        A = 0; B = 0; Cin = 0; #1000;
        A = 0; B = 0; Cin = 1; #1000;
        A = 0; B = 1; Cin = 0; #1000;
        A = 0; B = 1; Cin = 1; #1000;
        A = 1; B = 0; Cin = 0; #1000;
        A = 1; B = 0; Cin = 1; #1000;
        A = 1; B = 1; Cin = 0; #1000;
        A = 1; B = 1; Cin = 1; #1000;
    end
endmodule


	
	
	
	

