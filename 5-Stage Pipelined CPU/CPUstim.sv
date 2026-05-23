`timescale 1ns/10ps

module CPUstim();

  logic clk, reset;
  CPU dut (.clk(clk), .reset(reset));

  parameter ClockDelay = 10000;
  
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

  initial begin
    $display("Begin");
    
    reset <= 1;   @(posedge clk);      
	 reset <= 0;  repeat(1500) @(posedge clk);
    
    $display("End");
    $stop;
  end

endmodule

//cd "C:/Users/arjun/Desktop/EE 469/Lab 3"