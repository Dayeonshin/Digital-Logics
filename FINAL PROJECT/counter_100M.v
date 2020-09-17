`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2019 09:11:08 PM
// Design Name: 
// Module Name: counter_100M
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counter_100M(clk, cnt);
	input clk; //the 100MHz clk from the board
	output reg [31:0] cnt; //max value will be 100M, 32 bits for the size is more than enough
	
	initial begin
		cnt <= 0;
	end
	
	always @(posedge clk) begin
		if( cnt == 100000000 - 1 )	cnt <= 0;
		//if( cnt == 1000 )	cnt <= 0;
		else cnt <= cnt + 1;
	end
	
endmodule
