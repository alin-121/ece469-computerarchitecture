// If making changes to inputs and outputs in controlUnit.sv declare them as logic in the CPU.sv and change module
// instantiation ports.

// I have included Zero so when we do a CBZ we can set brTaken to (Zero from the ALU)
// For B_LT we can != negative and overflow i think. have to ask the TA.


// Breg is the flag going to the Mux before the program counter so it follows whatever instruction is in that register link = 0 in
// this case but Breg is 1 
module controlUnit(OpCode, Reg2Loc, UncondBr, BrTaken, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite, zero, overflow, 
                    MemRead, negative, Link, Breg, ADDIflag, SetFlags, NeedForward, Reg_30_Accessed);
  
  input logic  [10:0] OpCode;
  input logic         zero, overflow,negative, Reg_30_Accessed;
  output logic        Reg2Loc, NeedForward;
  output logic        UncondBr, BrTaken, MemToReg, MemWrite,MemRead, ALUSrc, RegWrite, ADDIflag, Link, Breg, SetFlags;
  output logic [2:0]  ALUOp;
  
  parameter [10:0]   ADDI = 11'b1001000100x, 
						   ADDS = 11'b10101011000,
						  	B    = 11'b000101xxxxx, 
						  	B_LT = 11'b01010100xxx,
						   BR   = 11'b11010110000,
						  	BL   = 11'b100101xxxxx,
						  	CBZ  = 11'b10110100xxx,
						  	LDUR = 11'b11111000010,
						  	STUR = 11'b11111000000,
						  	SUBS = 11'b11101011000;
  //logic BLT;
							
  //xor #50 over(BLT,zero,negative);
					  
  always_comb begin 
	 casex(OpCode)
			ADDI: begin
				 ADDIflag  = 1'b1;
				 RegWrite  = 1'b1;
				 ALUOp     = 3'b010;  
				 ALUSrc    = 1'b1;    
				 Reg2Loc   = 1'bx;    
				 MemWrite  = 1'b0;
	          MemRead   = 1'b0;					 
				 MemToReg  = 1'b0;    
				 BrTaken   = 1'b0;    
				 UncondBr  = 1'bx;      
				 Link      = 1'b0;    
				 Breg      = 1'b0;
	          SetFlags  = 1'b0;
				 
	          NeedForward = 1'b0;		 
			end
			
			ADDS: begin
				 ADDIflag  = 1'bx;
				 RegWrite  = 1'b1;
				 ALUOp     = 3'b010;  
				 ALUSrc    = 1'b0;    
				 Reg2Loc   = 1'b1;    
				 MemWrite  = 1'b0;
	          MemRead   = 1'b0;					 
				 MemToReg  = 1'b0;    
				 BrTaken   = 1'b0;    
				 UncondBr  = 1'bx;    
				 Link      = 1'b0;    
				 Breg      = 1'b0;
             SetFlags  = 1'b1;

	          NeedForward = 1'b0;					 
			end
			
			B: begin
				 ADDIflag  = 1'bx;
				 RegWrite  = 1'b0;
				 ALUOp     = 3'bxxx;  
				 ALUSrc    = 1'bx;    
				 Reg2Loc   = 1'bx;    
				 MemWrite  = 1'b0;	
	          MemRead   = 1'bx;			 
				 MemToReg  = 1'bx;    
				 BrTaken   = 1'b1;    
				 UncondBr  = 1'b1;      
				 Link      = 1'bx;    
				 Breg      = 1'b0;
	          SetFlags  = 1'b0;
	
	          NeedForward = 1'b0;		
			end
			

			B_LT: begin
				 ADDIflag  = 1'b1;
				 RegWrite  = 1'b0;
				 ALUOp     = 3'b010;  
				 ALUSrc    = 1'b1;    
				 Reg2Loc   = 1'b0;    
				 MemWrite  = 1'b0; 
				 MemRead   = 1'b0;		    
				 MemToReg  = 1'b0;     
				 BrTaken   = overflow ^ negative ;    
				 UncondBr  = 1'b0;      
				 Link      = 1'b0;    
				 Breg      = 1'b0;
	          SetFlags  = 1'b0;
	          NeedForward = 1'b0;					 
			end
			

			BR: begin
				 ADDIflag  = 1'bx;
				 RegWrite  = 1'b0;
				 ALUOp     = 3'b000;  
				 ALUSrc    = 1'b0;    
				 Reg2Loc   = 1'b0;    
				 MemWrite  = 1'b0; 
				 MemRead   = 1'bx;		    
				 MemToReg  = 1'bx;    
				 BrTaken   = ~Reg_30_Accessed;    
				 UncondBr  = 1'bx;      
				 Link      = 1'b0;    
				 Breg      = 1'b1;
	          SetFlags  = 1'b0;
	          NeedForward = 1'b1;					 
			end
			

			BL: begin
				 ADDIflag  = 1'bx;
				 RegWrite  = 1'b1;
				 ALUOp     = 3'bxxx;  
				 ALUSrc    = 1'bx;    
				 Reg2Loc   = 1'bx;    
				 MemWrite  = 1'b0; 
				 MemRead   = 1'bx;		    
				 MemToReg  = 1'bx;    
				 BrTaken   = 1'b1;    
				 UncondBr  = 1'b1;    
				 Link      = 1'b1;    
				 Breg      = 1'b0;
	          SetFlags  = 1'b0;
	          NeedForward = 1'b0;					 
			end
			
			CBZ: begin
				 ADDIflag  = 1'bx;
				 RegWrite  = 1'b1;
				 ALUOp     = 3'b000;  
				 ALUSrc    = 1'b0;    
				 Reg2Loc   = 1'b0;    
				 MemWrite  = 1'b0; 
				 MemRead   = 1'b0;		    
				 MemToReg  = 1'b0;    
				 BrTaken   = zero;    
				 UncondBr  = 1'b0;      
				 Link      = 1'b0;    
				 Breg      = 1'b0;
	          SetFlags  = 1'b0;
	          NeedForward = 1'b1;					 
			end
			
			LDUR: begin
				 ADDIflag  = 1'b0;
				 RegWrite  = 1'b1;
				 ALUOp     = 3'b010;  
				 ALUSrc    = 1'b1;    
				 Reg2Loc   = 1'bx;    
				 MemWrite  = 1'b0; 
				 MemRead   = 1'b1;		    
				 MemToReg  = 1'b1;    
				 BrTaken   = 1'b0;    
				 UncondBr  = 1'bx;    
				 Link      = 1'b0;    
				 Breg      = 1'b0;
	          SetFlags  = 1'b0;
	          NeedForward = 1'b0;					 
			end
			
			STUR: begin
				 ADDIflag  = 1'b0;
				 RegWrite  = 1'b0;
				 ALUOp     = 3'b010;  
				 ALUSrc    = 1'b1;    
				 Reg2Loc   = 1'b0;    
				 MemWrite  = 1'b1; 
				 MemRead   = 1'b0;		    
				 MemToReg  = 1'bx;    
				 BrTaken   = 1'b0;    
				 UncondBr  = 1'bx;    
				 Link      = 1'b0;    
				 Breg      = 1'b0;
	          SetFlags  = 1'b0;
	
	          NeedForward = 1'b0;			
			end
			
			SUBS : begin
				 ADDIflag  = 1'b1;
				 RegWrite  = 1'b1;
				 ALUOp     = 3'b011;  
				 ALUSrc    = 1'b0;    
				 Reg2Loc   = 1'b1;    
				 MemWrite  = 1'b0;
	          MemRead   = 1'b0;					 
				 MemToReg  = 1'b0;    
				 BrTaken   = 1'b0;    
				 UncondBr  = 1'bx;    
				 Link      = 1'b0;    
				 Breg      = 1'b0;
             SetFlags  = 1'b1;

	          NeedForward = 1'b0;						 
			end
			
			default : begin
				 ADDIflag  = 1'b0;
				 RegWrite  = 1'b0;
				 ALUOp     = 3'b000;  
				 ALUSrc    = 1'b0;    
				 Reg2Loc   = 1'b0;    
				 MemWrite  = 1'b0;
	          MemRead   = 1'b0;					 
				 MemToReg  = 1'b0;    
				 BrTaken   = 1'b0;    
				 UncondBr  = 1'b0;    
				 Link      = 1'b0;    
				 Breg      = 1'b0;
             SetFlags  = 1'b0;

	          NeedForward = 1'b0;						 
			end
					
				  
	 endcase 
  end

endmodule
	 
	 
						  
						  
						  
	