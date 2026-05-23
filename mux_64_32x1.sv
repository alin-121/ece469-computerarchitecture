module mux_64_32x1(in,out,sel);

    input logic [63:0][31:0]in; //each register
    input logic [4:0] sel;
    output logic [63:0]out; // each position
	 
	 genvar i;
	 
	 generate 
		
		for(i = 0; i<64 ; i++) begin : makeMux
			mux_32x1 biguns (.in(in[i][31:0]),.out(out[i]),.sel);
		end 
	 endgenerate 
endmodule 

