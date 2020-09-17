`timescale 1ns / 1ps

module clock_scaling(clk_100MHz, clk_for_7seg);
	input clk_100MHz;
	output reg clk_for_7seg;
	reg [31:0] cnt;
	
	initial begin
		clk_for_7seg <= 0;
		cnt <= 0;
	end
	
	always @(posedge clk_100MHz) begin
		//Note: Don't need to divide by 2 or add 1 or anything because we are not 
		//		matching a certain period or frequency. Just slow down the clock 
		//		enough to be able to see the LED transitions.
		if( cnt == 100000 )	begin
			cnt <= 0;
			clk_for_7seg <= !clk_for_7seg;
		end
		else cnt <= cnt + 1;
	end


endmodule