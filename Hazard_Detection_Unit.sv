module Hazard_Detection_Unit(EX_MEM_memR, Disable_IF_ID, Disable_PC,Rd_EX_MEM,Rn_IF_ID,Rm_IF_ID, noop);

	input logic  EX_MEM_memR;
	input logic [4:0] Rd_EX_MEM,Rn_IF_ID,Rm_IF_ID;
	output logic Disable_IF_ID, Disable_PC, noop;
	
	always_comb begin 
		if(EX_MEM_memR &&((Rd_EX_MEM == Rn_IF_ID)||(Rd_EX_MEM == Rm_IF_ID)))begin
		  Disable_IF_ID = 1'b0;
		  Disable_PC = 1'b0;
		  noop =  1'b0;
		end else begin 
		  Disable_IF_ID = 1'b1;
		  Disable_PC = 1'b1;
		  noop =  1'b1;
		end
	end 
	
endmodule 