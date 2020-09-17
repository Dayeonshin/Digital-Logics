`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2019 06:40:32 PM
// Design Name: 
// Module Name: random
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


module random(
    input clk,
    output reg [4:0] X1,
    output reg [4:0] Y1,
    output reg [4:0] X2,
    output reg [4:0] Y2,
    output reg [4:0] X3,
    output reg [4:0] Y3
    );
    
    integer i=0;
    integer seed;
    
    initial begin
        X1 = 0;
        Y1 = 0;
        X2 = 0;
        Y2 = 0;
        X3 = 0;
        Y3 = 0;
        
        seed = 1;
        
    end
    
    always @(posedge clk)
        begin
        
            $display("X1: %d",X1);
            $display("Y1: %d",Y1);
            $display("X2: %d",X2);
            $display("Y2: %d",Y2);
            $display("X3: %d",X3);
            $display("Y3: %d",Y3);
            seed = seed + 1;
            if(seed < 0)   
                seed = -seed;
                
            i = i*9876 + 54321;
            X1 <= (i * 10 + seed) % 14 + 1;
            Y1 <= (i * 21 + seed) % 22 + 1;
            X2 <= (i * 57 + seed) % 14 + 1;
            Y2 <= (i * 411 + seed) % 22 + 1;
            X3 <= (i * 91 + seed) % 14 + 1;
            Y3 <= (i * 11 + seed) % 22 + 1;
        end
        
endmodule
