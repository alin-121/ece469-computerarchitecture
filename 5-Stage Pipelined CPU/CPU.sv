`timescale 1ps / 1ps

module CPU(clk, reset);
  input logic clk, reset;
  
  logic negative, zero, overflow, carry_out;
  
  // Final Flag registers
  logic FinalNegative, FinalZero, FinalOverflow, FinalCarry_Out;
  
  // Pipeline Logics
  logic zeroDetected, flush, Disable_PC, noop;
  logic [1:0] Forwarding_Mux_select_A, Forwarding_Mux_select_B, Forward_BR, SturForward;
  
                                                //Dw = MemToReg_Mux_out
																                  // ALU input b = ALUSrc_Mux_out
  logic [63:0] Dw, Da,Db, Din, Dout, AluResult, MemToReg_Mux_out, ALUSrc_Mux_out, ADDIflag_Mux_out,
               UncondBr_Mux_out, ShifterOut, FinalRegWrite_Mux_out, BR_Forwarding_mux_out;
  
  logic [63:0] ProgramCounterNextIn,ProgramCounterLastOut, ProgramCounterAluOut4bit, ProgramCounterBranchAluOut, 
               ProgramCounterFinalIn_From_Breg_Mux_out, ALU_A_In_Forward_Mux_Out, ALU_B_In_Forward_Mux_Out, 
					Din_Forward_Mux_out ;
  
  logic [63:0] ExtendedImm12, ExtendedDtAddr9;
  logic [63:0] ExtendedBrAddr26, ExtendedCondAddr19;
  
  logic [4:0] Reg2Loc_Mux_out; // Ab input 
  logic [3:0] useless, useless2;
  
  logic [31:0] instruction;
  logic [10:0] opcode;
  logic  [4:0] Rd, Rm, Rn, FinalDestinationRegister_Link_Mux_out;
  logic  [1:0] shamt;
  
  logic [25:0] BrAddr26;
  logic [18:0] CondAddr19;
  logic [11:0] Imm12; 
  logic  [8:0] DtAddr9;
  
  // Pipline holders 
  logic [255:0] IF_ID;
  logic [255:0] ID_EX;
  logic [255:0] EX_MEM;
  logic [255:0] MEM_WB;
  
  
  
  // Same for all 
  assign opcode = 	  IF_ID[31:21];
  
  // R, I, D type
  assign Rd = 	 	     IF_ID[4:0];
  assign Rn =          IF_ID[9:5];
  
  // R type 
  assign Rm = 	 	     IF_ID[20:16];
  assign shamt =  	  IF_ID[15:10];
	 	   
  // I type 
  assign Imm12 =  	  IF_ID[21:10];
  
  // D type
  assign DtAddr9 = 	  IF_ID[20:12];
  
  //B type
  assign BrAddr26 =    IF_ID[25:0];
  
  // CB type
  assign CondAddr19 =  IF_ID[23:5];
  
  assign Din = Db;
  
  
  // Control Unit outputs
  // If making changes to inputs and outputs in controlUnit.sv add them here 
  logic [10:0]  OpCode;
  logic         Reg2Loc;
  logic         UncondBr, BrTaken, MemToReg, MemWrite, ALUSrc, RegWrite, ADDIflag, Link, Breg, MemRead, SetFlags, NeedForward;
  logic [2:0]   ALUOp;
 
// ************************************************************************************************************************************************//       
                            // Main blocks ALU, REgfile, DataMemory, Instruction memory
  
	regfile pai      (.ReadData1(Da), .ReadData2(Db), .WriteData(FinalRegWrite_Mux_out), 
	                  .ReadRegister1(Rn), .ReadRegister2(Reg2Loc_Mux_out), 
							.WriteRegister(MEM_WB[132:128]),.RegWrite(MEM_WB[199]), .clk(clk));
					          
   alu MAINdutt     (.A(ALU_A_In_Forward_Mux_Out), .B(ALUSrc_Mux_out), .cntrl(ID_EX[214:212]), .result(AluResult),
							.negative(negative), .zero(zero),.overflow(overflow), .carry_out(carry_out));
				 
	datamem dutt     (.address(EX_MEM[127:64]), .write_enable(EX_MEM[135]),.read_enable(EX_MEM[136]), 
							.write_data(EX_MEM[63:0]), .clk(clk), .xfer_size(4'b1000), .read_data(Dout));
							
	// Need to change enable if doing hazard unit 		 
	pc thecounter    (.in(ProgramCounterFinalIn_From_Breg_Mux_out), .clk(clk), .enable(Disable_PC),
							.reset(reset), .out(ProgramCounterLastOut));
					 

	instructmem bruh (.address(ProgramCounterLastOut), .instruction(instruction), .clk(clk));

	controlUnit bet  (.OpCode(opcode), .Reg2Loc, .UncondBr, .BrTaken, .MemToReg, .ALUOp, .MemWrite, .ALUSrc, .RegWrite, .zero(zeroDetected), 
	                  .overflow(FinalOverflow), .MemRead, .negative(FinalNegative), .Link, .Breg, .ADDIflag, .SetFlags,
							.NeedForward,.Reg_30_Accessed(EX_MEM[136]));
	
// *************************************************************************************************************************************
  
  
  //ALU modified to a adder for the program counter 
  alu PCcounterALUby4             (.A(ProgramCounterLastOut), .B(64'd4), .cntrl(3'b010), .result(ProgramCounterAluOut4bit), 
                                   .negative(useless[0]), .zero(useless[1]),.overflow(useless[2]), .carry_out(useless[3]));
						  
  alu PCcounterALUbyBranchAddress (.A(ShifterOut), .B(IF_ID[159:96]), .cntrl(3'b010), 
                                   .result(ProgramCounterBranchAluOut), .negative(useless2[0]), .zero(useless2[1]),
											  .overflow(useless2[2]), .carry_out(useless2[3]));
																		  
  // Zero extenders 64 bits
  // DELETE ZeroExtender #(9 , 64) nineImm      (.in(Imm9),        .out(ExtendedImm9));
  ZeroExtender #(12, 64) twelveImm    (.in(ID_EX[237:226]),       .out(ExtendedImm12));
  
  // Sign extenders 64 bits
  signExtender #(9,  64)  DAddr       (.in(ID_EX[225:217]),     .out(ExtendedDtAddr9));
  
  // Sign extenders 64 bits
  signExtender #(26, 64) BrAddr       (.in(BrAddr26),    .out(ExtendedBrAddr26));
  signExtender #(19, 64) CondAddr     (.in(CondAddr19),  .out(ExtendedCondAddr19));	
  
  // All the muxes not involved with the Program counter
  // DELETE mux_64_2x1 IMM9orIMM19selector (.one(ExtendedImm12), .zero(ExtendedImm9), .out(ZeroExtender_Mux_out), .sel(Imm12Flag));
  
  
  
  mux_64_2x1 ADDIflag_Mux        (.one(ExtendedImm12), .zero(ExtendedDtAddr9), .out(ADDIflag_Mux_out), .sel(ID_EX[215]));
  
  mux_64_2x1 ALUSrcMux           (.one(ADDIflag_Mux_out), .zero(ALU_B_In_Forward_Mux_Out), .out(ALUSrc_Mux_out), 
                                  .sel(ID_EX[216]));
  
  mux_64_2x1 MemToregMux         (.one(MEM_WB[63:0]), .zero(MEM_WB[127:64]), .out(Dw), .sel(MEM_WB[134]));
  
  mux_64_2x1 BranchLinkMUX       (.one(MEM_WB[198:135]), .zero(Dw), .out(FinalRegWrite_Mux_out), 
                                  .sel(MEM_WB[133]));
											 
											 
											 
											 
         // For input into Ab
  mux_5_2x1 Reg2Loc_Mux          (.one(Rm),.zero(FinalDestinationRegister_Link_Mux_out),.out(Reg2Loc_Mux_out),
                                  .sel(Reg2Loc));
  
        // For input into Aw
  mux_5_2x1 AwInputMuxusedForBranchLink(.one(5'b11110),.zero(Rd),.out(FinalDestinationRegister_Link_Mux_out),.sel(Link));
  
  
  
  // Muxes of the PC counter part 
  mux_64_2x1 UncondBranchMux      (.one(ExtendedBrAddr26), .zero(ExtendedCondAddr19), .out(UncondBr_Mux_out), .sel(UncondBr));
  
  mux_64_2x1 BrTakenMux           (.one(ProgramCounterBranchAluOut), .zero(ProgramCounterAluOut4bit), 
											  .out(ProgramCounterNextIn), .sel(BrTaken));
										
  mux_64_2x1 BranchRegisterMUX    (.one(BR_Forwarding_mux_out), .zero(ProgramCounterNextIn), 
											  .out(ProgramCounterFinalIn_From_Breg_Mux_out), .sel(Breg));
  
  

  //shifter in pc for address allignment <<2

  shifter SingleShifterInPC (.value(UncondBr_Mux_out), .direction(1'b0), .distance(6'd2), .result(ShifterOut));
  
  
  // Flag registers
  D_FF_new_NEG neg (.q(FinalNegative),  .d(negative),  .enabledff(ID_EX[238]), .reset(1'b0),   .clk);
  D_FF_new_NEG ze  (.q(FinalZero),      .d(zero),      .enabledff(ID_EX[238]), .reset(1'b0),   .clk);
  D_FF_new_NEG ov  (.q(FinalOverflow),  .d(overflow),  .enabledff(ID_EX[238]), .reset(1'b0),   .clk);
  D_FF_new_NEG ca  (.q(FinalCarry_Out), .d(carry_out), .enabledff(ID_EX[238]), .reset(1'b0),   .clk);
// *************************************************************************************************************************************
                                  // Pipelining 
											  
											    //IF_ID
						 // have to change reset to FLush signal from control unit
  
  D_FF_32 ins       (.in(instruction), .clk(clk), .enable(Disable_IF_ID), .reset(BrTaken), .out(IF_ID[31:0]));	 //has enable
  
  D_FF_64 IF_ID_PC4 (.in(ProgramCounterAluOut4bit), .clk(clk), .reset(reset), .out(IF_ID[95:32]));
  D_FF_64 IF_ID_PC  (.in(ProgramCounterLastOut), .clk(clk), .reset(reset), .out(IF_ID[159:96]));
  
											 							 																				 
											   // ID_EX
										// 255 to 239 free
  logic finalMemWrite,finalMemRead, finalRegwrite, finalSetFlags;	
  
  mux_2x1 nooper0 (.in({MemWrite,1'b0}),.out(finalMemWrite),.sel(noop));
  mux_2x1 nooper1 (.in({MemRead,1'b0}),.out(finalMemRead),.sel(noop));
  mux_2x1 nooper2 (.in({RegWrite,1'b0}),.out(finalRegwrite),.sel(noop));
  mux_2x1 nooper3 (.in({SetFlags,1'b0}),.out(finalSetFlags),.sel(noop));
  
  
  
										
  D_FF_64 ID_EX_B   (.in(Db),                                      .clk(clk), .reset(reset), .out(ID_EX[63:0]));
  D_FF_64 ID_EX_A   (.in(Da),                                      .clk(clk), .reset(reset), .out(ID_EX[127:64]));
  D_FF_5  ID_EX_Rd  (.in(FinalDestinationRegister_Link_Mux_out),   .clk(clk), .reset(reset), .out(ID_EX[132:128]));
  
  
  D_FF    ID_EX_Link       (.q(ID_EX[133]), .d(Link),     .reset(reset), .clk(clk));
  D_FF    ID_EX_MemToReg   (.q(ID_EX[134]), .d(MemToReg), .reset(reset), .clk(clk));
  D_FF    ID_EX_MemWrite   (.q(ID_EX[135]), .d(finalMemWrite), .reset(reset), .clk(clk));
  D_FF    ID_EX_MemRead    (.q(ID_EX[136]), .d(finalMemRead),  .reset(reset), .clk(clk));
  
  D_FF_64 ID_EX_PC4 (.in(IF_ID[95:32]), .clk(clk), .reset(reset), .out(ID_EX[200:137]));
  
  D_FF    ID_EX_RegWrite      (.q(ID_EX[201]),.d(finalRegwrite),.reset(reset), .clk(clk));
  
  D_FF_5  ID_EX_Rm    (.in(Reg2Loc_Mux_out),    .clk(clk), .reset(reset), .out(ID_EX[206:202]));
  D_FF_5  ID_EX_Rn    (.in(Rn),                 .clk(clk), .reset(reset), .out(ID_EX[211:207]));
  D_FF_3  ID_EX_ALUOp (.in(ALUOp),              .clk(clk), .reset(reset), .out(ID_EX[214:212]));
   
  D_FF    ID_EX_ADDIflag    (.q(ID_EX[215]), .d(ADDIflag),.reset(reset), .clk(clk));
  D_FF    ID_EX_ALUSrc      (.q(ID_EX[216]), .d(ALUSrc),  .reset(reset), .clk(clk));
  
  D_FF_9  ID_EX_DtAddr9 (.in(DtAddr9), .clk(clk), .reset(reset), .out(ID_EX[225:217]));
  
  D_FF_12 ID_EX_Imm12   (.in(Imm12), .clk(clk), .reset(reset), .out(ID_EX[237:226]));
  
  D_FF    ID_EX_SetFlags   (.q(ID_EX[238]), .d(finalSetFlags),  .reset(reset), .clk(clk));
  
  
  
  
  
  
                                   // EX_MEM
								    // 255 to 202 is free 
  D_FF_64 EX_MEM_Din      (.in(Din_Forward_Mux_out),    .clk(clk), .reset(reset), .out(EX_MEM[63:0]));
  D_FF_64 EX_MEM_ALU      (.in(AluResult),      .clk(clk), .reset(reset), .out(EX_MEM[127:64]));
  D_FF_5  EX_MEM_Rd       (.in(ID_EX[132:128]), .clk(clk), .reset(reset), .out(EX_MEM[132:128]));
  
  D_FF    EX_MEM_Link       (.q(EX_MEM[133]), .d(ID_EX[133]),  .reset(reset),  .clk(clk));
  D_FF    EX_MEM_MemToReg   (.q(EX_MEM[134]), .d(ID_EX[134]),  .reset(reset),  .clk(clk));
  D_FF    EX_MEM_MemWrite   (.q(EX_MEM[135]), .d(ID_EX[135]),  .reset(reset),  .clk(clk));
  D_FF    EX_MEM_MemRead    (.q(EX_MEM[136]), .d(ID_EX[136]),  .reset(reset),  .clk(clk));
  
  D_FF_64 EX_MEM_PC4    (.in(ID_EX[200:137]), .clk(clk), .reset(reset), .out(EX_MEM[200:137]));
  
  D_FF    EX_MEM_RegWrite   (.q(EX_MEM[201]), .d(ID_EX[201]),  .reset(reset),  .clk(clk));
  
  //D_FF_64  EX_MEM_B_tap  (.in(ID_EX[278:215]),  .clk(clk), .reset(reset), .out(EX_MEM[265:202]));
  
  
  
  
  
												// MEM_WB 
								// 255 to 200 is free. Keep TRACK
								
  D_FF_64 MEM_WB_MEMout   		  (.in(Dout),             .clk(clk), .reset(reset), .out(MEM_WB[63:0]));
  D_FF_64 MEM_WB_ALUResult      (.in(EX_MEM[127:64]),    .clk(clk), .reset(reset), .out(MEM_WB[127:64]));
  D_FF_5  MEM_WB_Rd             (.in(EX_MEM[132:128]),  .clk(clk), .reset(reset), .out(MEM_WB[132:128]));
  
  D_FF    MEM_WB_Link       (.q(MEM_WB[133]), .d(EX_MEM[133]),  .reset(reset),  .clk(clk));
  D_FF    MEM_WB_MemToReg   (.q(MEM_WB[134]), .d(EX_MEM[134]),  .reset(reset),  .clk(clk));
  
  D_FF_64 MEM_WB_PC4        (.in(EX_MEM[200:137]), .clk(clk), .reset(reset), .out(MEM_WB[198:135]));
  
  D_FF    MEM_WB_RegWrite   (.q(MEM_WB[199]),  .d(EX_MEM[201]), .reset(reset),  .clk(clk));
  
  
  
  
  
//*************************************************************************************************************************************
                                             // Hardware Added for pipelining 
															
	// need a mux for forwarding Da and ALU Mux out 
	 mux_64_4x1 Forward_Rn    (.one_one(64'b0), .one_zero(EX_MEM[127:64]), .zero_one(FinalRegWrite_Mux_out), 
	                           .zero_zero(ID_EX[127:64]), .sel(Forwarding_Mux_select_A), .out(ALU_A_In_Forward_Mux_Out));
								 
	 mux_64_4x1 Forward_Rm    (.one_one(64'b0), .one_zero(EX_MEM[127:64]), .zero_one(FinalRegWrite_Mux_out), 
	                           .zero_zero(ID_EX[63:0]), .sel(Forwarding_Mux_select_B), .out(ALU_B_In_Forward_Mux_Out));
									
	 mux_64_4x1 Forward_BRins (.one_one(AluResult), .one_zero(EX_MEM[127:64]), .zero_one(FinalRegWrite_Mux_out), 
	                           .zero_zero(Db), .sel(Forward_BR), .out(BR_Forwarding_mux_out));
										
	 mux_64_4x1 Forward_Stuse (.one_one(64'b0), .one_zero(EX_MEM[127:64]), .zero_one(FinalRegWrite_Mux_out), 
	                           .zero_zero(ID_EX[63:0]), .sel(SturForward), .out(Din_Forward_Mux_out));
   
	
	
	// zero detector 
	 zeroFlag ZeroCheckGate(.result(BR_Forwarding_mux_out), .zero(zeroDetected));
	
	
	// B_LT detector
 	
	
	// NOP MUX 
	
//***********************************************************************************************************************************
	                                       // Forwarding_Unit 
														
	
    ForwardingUnit yeah (.Rd_IF_ID(Rd), .Rd_ID_EX(ID_EX[132:128]), .Rd_EX_MEM(EX_MEM[132:128]), .Rd_MEM_WB(MEM_WB[132:128]), 
								 .Rn(ID_EX[211:207]), .Rm(ID_EX[206:202]), .RegWrite_EX_MEM(EX_MEM[201]), 
								 .RegWrite_MEM_WB(MEM_WB[199]), .ForwardA(Forwarding_Mux_select_A), 
								 .ForwardB(Forwarding_Mux_select_B), .BranchForward(Forward_BR), .Breg(NeedForward),.ID_EX_MemWr(ID_EX[135]),
								 .SturForward(SturForward));
								 
   Hazard_Detection_Unit meh (.EX_MEM_memR(EX_MEM[136]), .Disable_IF_ID, .Disable_PC,
										.Rd_EX_MEM(EX_MEM[132:128]),.Rn_IF_ID(Rn),.Rm_IF_ID(Reg2Loc_Mux_out),.noop);
 
  			
endmodule 

