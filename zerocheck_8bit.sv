`timescale 1ps / 1ps

module zerocheck_8bit(in, isZero);
  input logic [7:0] in;
  output logic isZero;
  
  wire[3:0] secondRow;
  wire[1:0] finalRow;
  wire finalres;
  
  or #50 EtF1 (secondRow[3], in[7],in[6]);
  or #50 EtF2 (secondRow[2], in[5],in[4]);
  or #50 EtF3 (secondRow[1], in[2],in[3]);
  or #50 EtF4 (secondRow[0], in[1],in[0]);
  
  or #50 EtFF1 (finalRow[1], secondRow[3],secondRow[2]);
  or #50 EtFF2 (finalRow[0], secondRow[1],secondRow[0]);
  
  or #50 EtFFF3 (finalres, finalRow[1],finalRow[0]);
  
  not #50 finish (isZero, finalres);
  
endmodule 


module zerocheck_8bit_testbench();
    logic [7:0] in;
    logic isZero;

    zerocheck_8bit test (.in, .isZero);

    initial begin
        in = 8'b00000000; #1000;
        in = 8'b00000001; #1000;
        in = 8'b00010000; #1000;
        in = 8'b11111111; #1000;
        in = 8'b10000000; #1000;
        in = 8'b00000000; #1000;
        in = 8'b00000001; #1000;
		  in = 8'b00000000; #1000;
        in = 8'b00000001; #1000;
    end
endmodule
  
  
  
  
  
  

  
  
  

