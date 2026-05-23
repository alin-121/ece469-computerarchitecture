
`timescale 1ps / 1ps


module mux_64_2x1(one,zero,out,sel);

    input logic [63:0] one,zero; 
    input logic  sel;
    output logic [63:0]out; 
	 
	 genvar i;
	 
	 generate 
		
		for(i = 0; i<64 ; i++) begin : makeMux
			mux_2x1 combine (.in({one[i],zero[i]}), .out(out[i]),.sel(sel));
		end 
	 endgenerate 
endmodule 

module mux_64_2x1_testbench();
    logic [63:0] one, zero;
    logic sel;
    logic [63:0] out;

    mux_64_2x1 test (.one(one), .zero(zero), .out(out), .sel(sel));

    initial begin
        sel = 0;                                     #1000;
                                                                                           #1000;
                          one  = 64'hAAAAAAAAAAAAAAAA;  zero = 64'h5555555555555555;       #1000;
                                                        zero = 64'h00000000FFFFFFFF;       #1000;
        sel  = 1;         one = 64'hDEADBEEFCAFEBABE;                                      #1000;
                          one = 64'h1234567890ABCDEF;                                      #1000;
        sel  = 0;                                       zero = 64'hFFFFFFFF00000000;       #1000;
                                                                                           #10000;
    end
endmodule
