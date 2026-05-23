`timescale 1ps / 1ps

module ForwardingUnit(Rd_IF_ID, Rd_ID_EX, Rd_EX_MEM, Rd_MEM_WB, Rn, Rm, RegWrite_EX_MEM, RegWrite_MEM_WB, ForwardA, ForwardB,
                      BranchForward, Breg, ID_EX_MemWr, SturForward);

	input  logic [4:0] Rd_IF_ID, Rd_ID_EX, Rd_EX_MEM, Rd_MEM_WB, Rn, Rm;
	input  logic       RegWrite_EX_MEM, RegWrite_MEM_WB, Breg,ID_EX_MemWr;
	output logic [1:0] ForwardA, ForwardB, BranchForward, SturForward; 
	
	always_comb begin
	
		if ((RegWrite_EX_MEM) && (Rd_EX_MEM != 5'b11111) && (Rd_EX_MEM == Rn)) begin
			ForwardA = 2'b10 ;
		end else if ((RegWrite_MEM_WB) && (Rd_MEM_WB != 5'b11111) && !(RegWrite_EX_MEM && Rd_EX_MEM != 5'b11111 && 
	                Rd_EX_MEM == Rn) && (Rd_MEM_WB == Rn)) begin
			ForwardA = 2'b01;	
		end else begin
			ForwardA = 2'b00;	
		end	
		
		if ((RegWrite_EX_MEM) && (Rd_EX_MEM != 5'b11111) && (Rd_EX_MEM == Rm)) begin
			ForwardB = 2'b10;
		end else if ((RegWrite_MEM_WB) && (Rd_MEM_WB != 5'b11111) && !(RegWrite_EX_MEM && Rd_EX_MEM != 5'b11111 && 
	                Rd_EX_MEM == Rm) && (Rd_MEM_WB == Rm)) begin
			ForwardB = 2'b01;
		end else begin
			ForwardB = 2'b00;	
		end
		
		if(Breg) begin 
		   if(Rd_IF_ID == Rd_ID_EX)begin
				BranchForward = 2'b11;      
			
			end else if(Rd_IF_ID == Rd_EX_MEM) begin 
			   BranchForward = 2'b10;
			
			end else begin
		      BranchForward = 2'b00;
			end
		end else begin
		      BranchForward = 2'b00;
		end
		
		if(ID_EX_MemWr) begin 
		   if(Rd_EX_MEM == Rd_ID_EX)begin
				SturForward = 2'b10;      
			
			end else if(Rd_ID_EX == Rd_MEM_WB) begin 
			   SturForward = 2'b01;
			
			end else begin
		      SturForward = 2'b00;
			end
		end  else begin
		      SturForward = 2'b00;
		end
		
	end 
endmodule  