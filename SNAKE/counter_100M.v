`timescale 1ns / 1ps

/*
A counter that counts up to 100,000,000 - 1, at chich point it resets itself to 0
*/
module counter_100M(clk, cnt,clk_scl);
	input clk; //the 100MHz clk from the board
	output reg [31:0] cnt; //max value will be 100M, 32 bits for the size is more than enough
	output reg clk_scl;
	
	initial begin
		cnt <= 0;
		clk_scl <= 0;
	end
	
	always @(posedge clk) begin
		if( cnt == 100000000 - 1 )	cnt <= 0;
		else cnt <= cnt + 1;
	end
	
	always @(posedge clk) begin
        cnt <=0;
        if (cnt<100000000/2-1) cnt <= cnt+1;
        else begin
            cnt<=0;
            clk_scl = !clk_scl;
        end
    end
endmodule