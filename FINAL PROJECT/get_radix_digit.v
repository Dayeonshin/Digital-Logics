`timescale 1ns / 1ps

module get_radix_digit(clk, number, pos, digit);
    input clk;
	input [15:0] number;
	input [3:0] pos;
//	input [1:0] radix;
	output reg [3:0] digit;
	
	reg [15:0] temp;
	integer i;
	
	//Note: radix = 0 means binary radix = 1 means decimal, radix = 2 means hex
	
	//Brainstorming
	//1. mathematically get digit from number
	//	a. last digit (pos 8) would be: number % 10
	//	b. second to last digit (pos 7) would be: (number / 10) % 10
	//	c. third to last digit (pos 6) would be: (number / 100) % 10
	//	d. pattern is: (number / 10 ** (8 - pos)) % 10
	//2. mathematically get hex digit from number
	//	a. last hex digit (pos 8) would be: number % 16
	//	b. second to last hex digit (pos 7) would be: (number / 16) % 16
	//	c. third to last hex digit (pos 6) would be: (number / (16*16)) % 16
	//	d. pattern is: (number / 16 ** (8 - pos)) % 16
	//3. mathematically get bit from number
	//	a. last bit (pos 8) would be: number % 2
	//	b. second to last bit (pos 7) would be: (number / 2) % 2
	//	c. third to last bit (pos 6) would be: (number / (2*2)) % 2
	//	d. pattern is: (number / 2 ** (8 - pos)) % 2
	
	initial begin
	   digit <= 0;
	end
	
	always @(posedge clk) begin
        temp = number;
        for(i = 0; i < 8 - pos; i = i + 1) temp = temp / 10;
        digit = temp % 10;

	end
	
endmodule