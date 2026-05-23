
`timescale 1ps / 1ps


module mux_5_2x1(one,zero,out,sel);

    input logic [4:0] one,zero; 
    input logic  sel;
    output logic [4:0]out; 
	 
	 genvar i;
	 
	 generate 
		
		for(i = 0; i<5 ; i++) begin : makeMux
			mux_2x1 combine (.in({one[i],zero[i]}), .out(out[i]),.sel(sel));
		end 
	 endgenerate 
endmodule 

module mux_5_2x1_testbench();
    logic [4:0] one, zero;
    logic sel;
    logic [4:0] out;

    mux_5_2x1 test (one, zero, out, sel);

    initial begin
                         sel = 0;                     #1000;
								                              #1000;
        one = 5'b10101;  zero = 5'b01010;             #1000;
                         zero = 5'b00011;             #1000;
        sel = 1;         one = 5'b11011;              #1000;
                         one = 5'b00100;              #1000;
        sel = 0;         zero = 5'b11100;             #1000;
                                                      #10000;
    end
endmodule

