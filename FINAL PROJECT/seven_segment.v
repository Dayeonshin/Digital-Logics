`timescale 1ns / 1ps

module seven_segment(clk, number, btn_l, btn_r, anode, segment);
	input clk;
	input btn_l, btn_r;
	input [15:0] number;
	output [7:0] anode;
	output [6:0] segment;
	
	wire clk_for_7seg;
	reg [3:0] pos;
	wire [1:0] radix;
	wire [3:0] digit;
	//Brainstorm
	//Need to get input from switches and show on 7 segment based on radix
	
	clock_scaling clk_scl( 
		.clk_100MHz(clk), 
		.clk_for_7seg(clk_for_7seg) 
	);
	get_radix_digit get_digit( 
	    .clk(clk), //because exponentiation is not supported
		.number(number), 
		.pos(pos), 

		.digit(digit) 
	);
	send_7seg seven_seg( 
		.scaled_clk(clk_for_7seg), 
		.digit(digit), 
		.pos(pos),
		.anode(anode), 
		.segment(segment)
	);
	
	assign radix = btn_l ? 0: (btn_r ? 2: 1);
	
	initial begin
	   pos <= 1;
	end
	
	always @(posedge clk_for_7seg) begin
	   if(pos == 8) pos <= 1;
	   else pos <= pos + 1;
	end
	
	
	
endmodule