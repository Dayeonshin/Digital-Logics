`timescale 1ns / 1ps

/*
Instantiates and wires up the 100,000,000 counter. 
Instantiates and wires up the LED matrix protocol module which transmits the bits to the LED matrix board.

Sets up the 2D array that represents the game board. There are two matrices. game_matrix is used in the game,
    as you would expect your game to look like. matrix_to_send reorganizes the game_matrix before sending to the 
    LED matrix board. You do not have to worry about matrix_to_send; you can create it using 
    transform_mat_for_board(), and then gen_seq_to_send() will create the sequence that gets sent to the board. 
    Remember, the LED matrix board is 16x24 so those are the dimensions of the 2D arrays as well. 
You will be modifying the always block. For now, it just turns all LEDs on and off every second. You will create the
    game and then update the 2D array accordingly. Feel free to modify any of the code that you have been given.
Display statements have been used and can be seen to view the output. $write and $display work the same way, except 
    that $display adds a newline character at the end.
*/
module main(clk, cs, write, data, debug,button);
	input clk;
	input [4:0]button;
	output cs, write, data, debug;

    wire [31:0] cnt_100M;
    wire clk_scl;
	reg [393:0] seq;
	reg [31:0] seq_nbits;
	wire [3:0] current_heading;
	wire [31:0] length;
    
	
	integer x_value[1000:0];
	integer y_value[1000:0];
	reg[3:0] headX;
    reg[4:0] headY;
	
	//reg [31:0] game_matrix [15:0][23:0];
	integer game_matrix [15:0][23:0];
	integer matrix_to_send [15:0][23:0];

	parameter ROWS = 16;
	parameter COLS = 24;
	parameter MATRIX_TOTAL = ROWS * COLS; //384
	integer i, j, k;

	//from module counter_100M(clk, cnt);
	counter_100M counter(
		.clk(clk),
		.clk_scl(clk_scl),
		.cnt(cnt_100M));

	//from module LED_matrix(clk, cnt_100M, wr_seq, wr_seq_nbits, cs, write, data, debug);
	LED_matrix mat(
		.clk(clk),
		.cnt_100M(cnt_100M),
		.wr_seq(seq),
		.wr_seq_nbits(seq_nbits),
		.cs(cs),
		.write(write),
		.data(data),
		.debug(debug));
		
	direction direction(
	   .current_heading(current_heading), 
	   .button(button) ,
	   .clk(clk),
	   .length(length)
	);
	
	
    //transfer 8 slots to where they map on board    
    task transfer_line;
        input integer to_row, to_col, from_row, from_col;
        begin
            for( i=0; i<8; i = i + 1 ) begin
                matrix_to_send[to_row][to_col + i] = game_matrix[from_row][from_col + i];
            end        
        end
	endtask

    //how to transfer each line
    task transform_mat_for_board;
        begin
            transfer_line(0,0,0,0);
            transfer_line(0,8,8,0);
            transfer_line(0,16,1,0);
            
            transfer_line(1,0,9,0);
            transfer_line(1,8,2,0);
            transfer_line(1,16,10,0);
            
            transfer_line(2,0,3,0);
            transfer_line(2,8,11,0);
            transfer_line(2,16,4,0);
            
            transfer_line(3,0,12,0);
            transfer_line(3,8,5,0);
            transfer_line(3,16,13,0);
            
            transfer_line(4,0,6,0);
            transfer_line(4,8,14,0);
            transfer_line(4,16,7,0);
            
            transfer_line(5,0,15,0);
            transfer_line(5,8,0,8);
            transfer_line(5,16,8,8);
            
            transfer_line(6,0,1,8);
            transfer_line(6,8,9,8);
            transfer_line(6,16,2,8);
            
            transfer_line(7,0,10,8);
            transfer_line(7,8,3,8);
            transfer_line(7,16,11,8);
            
            transfer_line(8,0,4,8);
            transfer_line(8,8,12,8);
            transfer_line(8,16,5,8);
            
            transfer_line(9,0,13,8);
            transfer_line(9,8,6,8);
            transfer_line(9,16,14,8);
            
            transfer_line(10,0,7,8);
            transfer_line(10,8,15,8);
            transfer_line(10,16,0,16);
                
            transfer_line(11,0,8,16);
            transfer_line(11,8,1,16);
            transfer_line(11,16,9,16);
            
            transfer_line(12,0,2,16);
            transfer_line(12,8,10,16);
            transfer_line(12,16,3,16);
            
            transfer_line(13,0,11,16);
            transfer_line(13,8,4,16);
            transfer_line(13,16,12,16);
            
            transfer_line(14,0,5,16);
            transfer_line(14,8,13,16);
            transfer_line(14,16,6,16);
            
            transfer_line(15,0,14,16);
            transfer_line(15,8,7,16);
            transfer_line(15,16,15,16);
            
        end
    endtask
    
    task gen_seq_to_send;
        begin
            seq = 5 << 7;
            k = 0;
            for( i=0; i<ROWS; i = i + 1 ) begin
                for( j=0; j<COLS; j = j + 1 ) begin
                    if(matrix_to_send[i][j] == 0)	seq = seq << 1;
                    else    seq = (seq << 1) + 1;
                    k = k + 1;
                end
            end
        end
	endtask
	

	initial begin
	    
		seq_nbits <= 394;
		//init matrices
		for( i=0; i<ROWS; i = i + 1 ) begin
			for( j=0; j<COLS; j = j + 1 ) begin
				game_matrix[i][j] = 0;
				matrix_to_send[i][j] = 0;
			end
		end		
		
		transform_mat_for_board();
		gen_seq_to_send();
		
		//display matrix, for debugging
		$display("\nTo Send matrix: in initial after transform");
		for( i=0; i<ROWS; i = i + 1 ) begin
			for( j=0; j<COLS; j = j + 1 ) begin
				$write("%D ", matrix_to_send[i][j]);
			end
			$write("\n");
		end
	end

	always @(posedge clk) begin
		if(!cnt_100M) begin
		
            for( i=0; i<ROWS; i = i + 1 ) begin
                for( j=0; j<COLS; j = j + 1 ) begin
                    game_matrix[i][j] = !game_matrix[i][j];
                end
            end		
            
            transform_mat_for_board();
            gen_seq_to_send();
            
        end
	end
	
	
	
	
	
	
	
	
	
	
	
	always @(posedge clk_scl) begin 
        if (i==384) i=0;
        else if (i<384) i = i+1;
        
        case(current_heading) 
            4'b0001: begin 
                headX = (headX +1)%24;
                x_value[i] = headX;
                y_value[i] = headY;
            end
            4'b0010: begin
                headY = (headY +1)%16;
                x_value[i] = headX;
                y_value[i] = headY;
            end
            4'b0100: begin
                headX = (headX -1)%24;
                x_value[i] = headX;
                y_value[i] = headY;
            end
            4'b1000: begin
                headY = (headY -1)%16;
                x_value[i] = headX;
                y_value[i] = headY;
            end 
            
        
        endcase
    end 
    
	always @(posedge clk_scl) begin
        for (k = i; k>i-length;k = k-1) begin
            game_matrix[y_value[k]][x_value[k]]=1;
        end 
    end
endmodule
