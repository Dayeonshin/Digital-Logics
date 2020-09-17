`timescale 1ns / 1ps

module send_7seg(scaled_clk, digit, pos, anode, segment);
	input scaled_clk;
	input [3:0] digit;
	input [3:0] pos;
	output reg [7:0] anode;
	output reg [6:0] segment;
	
	initial begin
		anode <= 8'b11111111;
		segment <= 7'b1111111;
	end
	
	always @(posedge scaled_clk) begin
		case (digit)
			0: segment <= 7'b1000000;
			1: segment <= 7'b1111001;
			2: segment <= 7'b0100100;
			3: segment <= 7'b0110000;
			4: segment <= 7'b0011001;
			5: segment <= 7'b0010010;
			6: segment <= 7'b0000010;
			7: segment <= 7'b1111000;
			8: segment <= 7'b0000000;
			9: segment <= 7'b0010000;
			10: segment <= 7'b0001000;
			11: segment <= 7'b0000011;
			12: segment <= 7'b0100111;
			13: segment <= 7'b0100001;
			14: segment <= 7'b0000110;
			15: segment <= 7'b0001110;
		endcase
		
		case (pos)
		     1: anode <= 8'b11111110;
		     2: anode <= 8'b11111101;
		     3: anode <= 8'b11111011;
		     4: anode <= 8'b11110111;
		     5: anode <= 8'b11101111;
		     6: anode <= 8'b11011111;
		     7: anode <= 8'b10111111;
		     8: anode <= 8'b01111111;
		endcase
	end

endmodule

