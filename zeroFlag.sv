`timescale 1ps / 1ps

module zeroFlag(result, zero);

  input logic [63:0] result;
  output logic zero;
  
  logic[7:0] firstRow;
  logic finalres, temp1, temp2; 
  
  zerocheck_8bit dut1 (.in(result[63:56]),.isZero(firstRow[7]));
  zerocheck_8bit dut2 (.in(result[55:48]),.isZero(firstRow[6]));
  zerocheck_8bit dut3 (.in(result[47:40]),.isZero(firstRow[5]));
  zerocheck_8bit dut4 (.in(result[39:32]),.isZero(firstRow[4]));
  zerocheck_8bit dut5 (.in(result[31:24]),.isZero(firstRow[3]));
  zerocheck_8bit dut6 (.in(result[23:16]),.isZero(firstRow[2]));
  zerocheck_8bit dut7 (.in(result[15:8]),.isZero(firstRow[1]));
  zerocheck_8bit dut8 (.in(result[7:0]),.isZero(firstRow[0]));
				 
  zerocheck_8bit fin (.in(firstRow[7:0]), .isZero(finalres));
  
  and #50 tempi1(temp1, firstRow[7],firstRow[6],firstRow[5],firstRow[4]);
  and #50 tempi2(temp2, firstRow[3],firstRow[2],firstRow[1],firstRow[0]);
  and #50 tempi3(zero, temp1,temp2);
  
  
	
endmodule

module zeroFlag_testbench();
    logic [63:0] result;
    logic zero;

    zeroFlag test (.result, .zero);

    initial begin
        result = 64'b0;  #1000;
        result = 64'd1;  #1000;
        result = 64'd8;  #1000;
        result = 64'b0;  #1000;
        result = 64'd2;  #1000;
        result = 64'd3;  #1000;
        result = 64'b0;  #1000;
        result = 64'd1;  #1000;
        result = 64'd0;  #1000;
    end
endmodule
