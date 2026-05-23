// Test bench for ALU
`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B 
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant


module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	logic [63:0] needresult;
	
		$display("%t testing ALU_PASS_B operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		
		$display("%t testing ALU_ADD operations", $time);
		cntrl = ALU_ADD;
		for (i=100; i<200; i++) begin
			A = $random(); B = $random();
			needresult = A + B;
			#(delay);
			assert(result == needresult);
		end
		
		
		$display("%t testing ALU_SUBTRACT operations", $time);
		cntrl = ALU_SUBTRACT;
		for (i=200; i<300; i++) begin
			A = $random(); B = $random();
			needresult = A - B;
			#(delay);
			assert(result == needresult);
		end
		
		
		$display("%t testing ALU_AND operations", $time);
		cntrl = ALU_AND;
		for (i=300; i<400; i++) begin
			A = $random(); B = $random();
			needresult = A & B;
			#(delay);
			assert(result == needresult);
		end
		
		$display("%t testing ALU_OR operations", $time);
		cntrl = ALU_OR;
		for (i=400; i<500; i++) begin
			A = $random(); B = $random();
			needresult = A | B;
			#(delay);
			assert(result == needresult);
		end
		
		$display("%t testing ALU_XOR operations", $time);
		cntrl = ALU_XOR;
		for (i=500; i<600; i++) begin
			A = $random(); B = $random();
			needresult = A ^ B;
			#(delay);
			assert(result == needresult);
		end
		
		
		$display("%t testing overflow", $time);
		cntrl = ALU_ADD;
		A = 64'h7FFFFFFFFFFFFFFF; B = 64'h0000000000000001;
		#(delay);
		assert(overflow == 1);
		
	end
endmodule
