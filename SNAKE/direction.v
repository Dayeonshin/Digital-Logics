`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2019 09:09:03 PM
// Design Name: 
// Module Name: direction
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


module direction(current_heading, button ,clk,length );
    input [4:0] button;
    input clk;
    output reg [31:0]length;
    output reg[3:0]current_heading;
    
    initial begin 
        length = 1;
        current_heading = 4'b0001;
    end
    
    always @(posedge clk) begin 
        if (button[0]==1'b0 && current_heading!=4'b0100) begin
            current_heading = 4'b0001;
        end
        else if (button[1]==1'b0 && current_heading!=4'b1000 )begin
            current_heading = 4'b0010;
        end 
        else if (button[2]==1'b0 && current_heading!=4'b0001)begin
            current_heading = 4'b0100;
        end
        else if (button[3]==1'b0 && current_heading!=4'b0010)begin
            current_heading = 4'b1000;
        end 
        else if (button[4]==1'b0)begin
            length = length +1;
        end 
    end 
    
    
    
    
        

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
