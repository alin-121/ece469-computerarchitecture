module regfile(ReadData1,ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister,RegWrite, clk);

	input logic RegWrite, clk;
	input logic [4:0]WriteRegister,ReadRegister1,ReadRegister2;
	input logic [63:0]WriteData;
	output logic [63:0]ReadData1,ReadData2;
	
	logic [63:0][31:0] temp;
	
	logic [31:0] enabler;
	
	decoder_5x32 decoderforReg (.in(WriteRegister),.out(enabler),.regWrite(RegWrite));
	
	genvar i,j,k; 
	integer x;
	
	generate 
		for(i=0; i<31; i++) begin : registers
		  for(j=0; j<64; j++) begin : flipFlops
		     D_FF_new_NEG sys (.q(temp[j][i]) , .d(WriteData[j]) , .enabledff(enabler[i]), .reset(1'b0), .clk(clk));
		  end 
		 end
	endgenerate 
	
   mux_64_32x1 bigtwo(.in(temp),.out(ReadData2),.sel(ReadRegister2));
	mux_64_32x1 bigone(.in(temp),.out(ReadData1),.sel(ReadRegister1));

	
	always_comb begin 
	  for(x = 0 ; x<64;x++) begin
			temp[x][31] = 0;
	  end 
	end 
	
	
	logic [31:0][63:0] regfile_view;

	genvar m, n;
	generate
	  for (m = 0; m < 32; m++) begin : rows
		 for (n = 0; n < 64; n++) begin : bits
			assign regfile_view[m][n] = temp[n][m];
		 end
	  end
	endgenerate

endmodule 
	
	
		 
	
	
	
	
	
	