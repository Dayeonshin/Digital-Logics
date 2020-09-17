`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2019 11:51:53 AM
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2019 04:39:20 PM
// Design Name: 
// Module Name: main
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


module main(clk,BTNU, BTND, BTNC, BTNL, BTNR, JA, anode, segment);
    input clk;
    input BTNU, BTND, BTNC, BTNL, BTNR;
    input [7:0] JA;
    output [7:0] anode;///////////
	output [6:0] segment;////////
    
    wire [31:0] cnt_100M;
    wire [3:0] Decode;
    wire [9:0] random;
    wire [4:0] Pos_tmp [3:0];
    wire [4:0] escR_tmp;
    wire [4:0] escC_tmp;
    reg [4:0] escR;
    reg [4:0] escC;
    reg [4:0] Pos [3:0];
    reg [8:0] game_matrix [15:0][23:0];
    reg [8:0] Vision [15:0][23:0];
    reg [8:0] matrix_to_send [15:0][23:0];
    reg [5:0] P1c;
    reg [4:0] P1r;
    reg [5:0] P2c;
    reg [4:0] P2r;
    reg [3:0] direc1;
    reg [3:0] direc2;
    reg [2:0] victory;
    integer i,j,k;
    integer num_display;
    integer p1_row_d, p1_col_d, p2_row_d, p2_col_d;
    
    random ran(
		    .clk(clk),
		    .X1(Pos_tmp[1]),
	        .Y1(Pos_tmp[0]),
	        .X2(Pos_tmp[3]),
	        .Y2(Pos_tmp[2]),
	        .X3(escR_tmp),
	        .Y3(escC_tmp)
	);

	
	
	seven_segment sengment_display(
	   .clk(clk),
       .number(num_display),
       .anode(anode),
       .segment(segment)
	);
	
    initial begin
        Pos[0]=8;//Pos_tmp[0];
        Pos[1]=2;//Pos_tmp[1];
        Pos[2]=10;//Pos_tmp[2];
        Pos[3]=8;//Pos_tmp[3];
        escR = 8;
        escC = 12;
        for (i = 0; i < 16; i = i + 1)//turn on all LEDs
            for (j = 0; j < 24; j = j + 1)
                game_matrix[i][j] = 1;
                
        for (i = 2; i <= 7; i = i + 1)
            game_matrix[i][1] = 0;
        game_matrix[7][2] = 0;
        game_matrix[7][3] = 0;
        game_matrix[8][3] = 0;
        game_matrix[9][3] = 0;
        for (i = 1; i <= 6; i = i + 1)
            game_matrix[10][i] = 0;
        for (i = 8; i <= 12; i = i + 1)
            game_matrix[i][7] = 0;
        game_matrix[11][2] = 0;
        for (i = 1; i <= 6; i = i + 1)
            game_matrix[12][i] = 0;
        game_matrix[13][1] = 0;
        for (i = 1; i <= 11; i = i + 1)
            game_matrix[14][i] = 0;
        game_matrix[13][5] = 0;
        game_matrix[13][11] = 0;
        game_matrix[13][12] = 0;
        game_matrix[13][13] = 0;
        game_matrix[10][12] = 0;
        game_matrix[11][12] = 0;
        game_matrix[12][12] = 0;
        for (i = 13; i <= 16; i = i + 1)
            game_matrix[14][i] = 0;
        game_matrix[11][12] = 0;
        game_matrix[12][12] = 0;
        for (i = 12; i <= 15; i = i + 1)
            game_matrix[10][i] = 0;
        game_matrix[11][14] = 0;
        for (i = 14; i <= 17; i = i + 1)
            game_matrix[12][i] = 0;
        for (i = 17; i <= 20; i = i + 1)
            game_matrix[13][i] = 0;
        game_matrix[14][18] = 0;
        game_matrix[14][20] = 0;
        game_matrix[14][21] = 0;
        game_matrix[14][22] = 0;
        game_matrix[11][22] = 0;
        game_matrix[12][22] = 0;
        game_matrix[13][22] = 0;
        game_matrix[11][20] = 0;
        game_matrix[11][21] = 0;
        game_matrix[10][19] = 0;
        game_matrix[10][20] = 0;
        game_matrix[9][17] = 0;
        game_matrix[9][18] = 0;
        game_matrix[9][19] = 0;
        game_matrix[10][17] = 0;
        game_matrix[8][19] = 0;
        game_matrix[8][20] = 0;
        game_matrix[8][21] = 0;
        game_matrix[8][22] = 0;
        for (i = 4; i <= 7; i = i + 1)
            game_matrix[i][21] = 0;
        game_matrix[6][22] = 0;
        game_matrix[4][20] = 0;
        for (i = 1; i <= 6; i = i + 1)
            game_matrix[i][19] = 0;
        game_matrix[2][20] = 0;
        game_matrix[2][21] = 0;
        game_matrix[2][22] = 0;
        game_matrix[1][17] = 0;
        game_matrix[1][18] = 0;
        game_matrix[2][15] = 0;
        game_matrix[2][16] = 0;
        game_matrix[2][17] = 0;
        for (i = 1; i <= 5; i = i + 1)
            game_matrix[i][14] = 0;
        game_matrix[4][16] = 0;
        game_matrix[4][17] = 0;
        game_matrix[4][18] = 0;
        game_matrix[5][16] = 0;
        for (i = 10; i <= 17; i = i + 1)
            game_matrix[6][i] = 0;
        game_matrix[7][17] = 0;
        game_matrix[8][17] = 0;
        game_matrix[7][15] = 0;
        game_matrix[9][15] = 0;
        for (i = 8; i <= 16; i = i + 1)
            game_matrix[8][i] = 0;
        game_matrix[9][10] = 0;
        game_matrix[10][10] = 0;
        game_matrix[11][10] = 0;
        game_matrix[11][9] = 0;
        game_matrix[12][9] = 0;
        for (i = 10; i <= 14; i = i + 1)
            game_matrix[1][i] = 0;
        game_matrix[4][12] = 0;
        game_matrix[4][13] = 0;
        game_matrix[7][12] = 0;
        game_matrix[2][12] = 0;
        game_matrix[3][12] = 0;
        for (i = 1; i <= 6; i = i + 1)
            game_matrix[i][10] = 0;
        game_matrix[7][5] = 0;
        game_matrix[8][5] = 0;
        game_matrix[9][5] = 0;
        game_matrix[6][6] = 0;
        game_matrix[7][6] = 0;
        for (i = 4; i <= 9; i = i + 1)
            game_matrix[5][i] = 0;
        game_matrix[6][3] = 0;
        game_matrix[6][4] = 0;
        game_matrix[6][8] = 0;
        game_matrix[7][8] = 0;
        game_matrix[1][2] = 0;
        game_matrix[2][2] = 0;
        game_matrix[2][3] = 0;
        game_matrix[3][3] = 0;
        game_matrix[4][3] = 0;
        game_matrix[1][4] = 0;
        game_matrix[2][4] = 0;
        game_matrix[1][5] = 0;
        game_matrix[1][6] = 0;
        game_matrix[2][6] = 0;
        game_matrix[3][6] = 0;
        game_matrix[3][7] = 0;
        game_matrix[3][8] = 0;
        game_matrix[2][8] = 0;
        game_matrix[2][9] = 0;
        
        
        for (i = 0; i < 16; i = i + 1)//turn off all LEDs
            for (j = 0; j < 24; j = j + 1)
                Vision[i][j] = 0;
        
    end
    
    Decoder C0(
			.clk(clk),
			.Row(JA[7:4]),
			.Col(JA[3:0]),
			.DecodeOut(Decode)
	);
	

    
    always @(posedge clk) begin
        
        $display("Pos_tmp:");
        for(i=0; i < 4; i = i + 1) $write("%d ", Pos_tmp[i]);
	    $write("\n");
        
        $display("escR_tmp %d", escR_tmp);
        $display("escC_tmp %d", escC_tmp);
        $display("Decode %d", Decode);
        
    
		if(!cnt_100M) begin
		//button player1
			if (BTNU) begin // up
				if (game_matrix[Pos[1]-1][Pos[0]]!=1) Pos[1] = Pos[1] - 1; //detect if next pos is valid
				direc1 = 0;
			end
			
			if (BTND) begin // down
				if (game_matrix[Pos[1]+1][Pos[0]]!=1) Pos[1] = Pos[1] + 1; //detect if next pos is valid
				direc1 = 1;
			end
			
			if (BTNL) begin // left
				if (game_matrix[Pos[1]][Pos[0]-1]!=1) Pos[0] = Pos[0] - 1; //detect if next pos is valid
				direc1 = 2;
			end
			if (BTNR) begin // right
				if (game_matrix[Pos[1]][Pos[0]+1]!=1) Pos[0] = Pos[0] + 1; //detect if next pos is valid
				direc1 = 3;
			end
			if (BTNC) begin // shoot
				if ((Pos[0] == Pos[2]) & (direc1 == 0 & (Pos[1] >= Pos[3])) || (direc1 == 1 & (Pos[1] <= Pos[3]))) begin //when player in same column and player 1 is facing player 2
				    victory = 1;
					if (Pos[1] <= Pos[3]) begin
						for( i = Pos[1]; i <= Pos[3]; i = i+1) begin
							if(game_matrix[i][Pos[0]]) victory = 0;
						end
					end
					else begin
						for( i = Pos[1]; i >= Pos[3]; i = i-1) begin
							if(game_matrix[i][Pos[0]]) victory = 0;
						end
					end
				end
				
				else if ((Pos[1] == Pos[3]) & (direc1 == 2 & (Pos[0] >= Pos[2])) || (direc1 == 4 & (Pos[0] <= Pos[2]))) begin
				    victory = 1;
					if (Pos[0] <= Pos[2]) begin
						for( i = Pos[0]; i <= Pos[2]; i = i+1) begin
							if(game_matrix[Pos[1]][i]) victory = 0;
						end
					end
					else begin
						for( i = Pos[0]; i >= Pos[2]; i = i-1) begin
							if(game_matrix[Pos[1]][i]) victory = 0;
						end
					end
				end
			end
		
		//keypad player2
			case (Decode)

					4'h2 :   // up
						begin
							if (game_matrix[Pos[3]-1][Pos[2]]!=1) Pos[3] = Pos[3] - 1; //detect if next pos is valid
							direc2 = 0;
						end
					4'h4 :   // left
						begin
							if (game_matrix[Pos[3]][Pos[2]-1]!=1) Pos[2] = Pos[2] - 1; //detect if next pos is valid
							direc2 = 2;
						end
					4'h5 :   // shoot
					   begin
                           if ((Pos[0] == Pos[2]) & (direc2 == 0 & (Pos[3] >= Pos[1])) || (direc2 == 1 & (Pos[3] <= Pos[1]))) begin //when player in same column and player 1 is facing player 2
                                victory = 2;
                                if (Pos[3] <= Pos[1]) begin
                                    for( i = Pos[3]; i <= Pos[1]; i = i+1) begin
                                        if( game_matrix[i][Pos[2]]) victory = 0;
                                    end
                                end
                                else begin
                                    for( i = Pos[3]; i >= Pos[1]; i = i-1) begin
                                        if( game_matrix[i][Pos[2]]) victory = 0;
                                    end
                                end
                            end
                            
                            else if ((Pos[1] == Pos[3]) & (direc2 == 2 & (Pos[2] >= Pos[0])) || (direc2 == 4 & (Pos[2] <= Pos[0]))) begin
                                victory = 2;
                                if (Pos[2] <= Pos[0]) begin
                                    for( i = Pos[2]; i <= Pos[0]; i = i+1) begin
                                        if( game_matrix[Pos[3]][i]) victory = 0;
                                    end
                                end
                                else begin
                                    for( i = Pos[2]; i >= Pos[0]; i = i-1) begin
                                        if( game_matrix[Pos[3]][i]) victory = 0;
                                    end
                                end
                            end
                        end
					4'h6 :   // right
						begin
							if (game_matrix[Pos[3]][Pos[2]+1]!=1) Pos[2] = Pos[2] + 1; //detect if next pos is valid
							direc2 = 3;
						end
					4'h8 :   // down
						begin
							if (game_matrix[Pos[3]+1][Pos[2]]!=1) Pos[3] = Pos[3] + 1; //detect if next pos is valid
							direc2 = 1;
						end
			
					
			endcase
		
		end

        P1c=Pos[0];
        P1r=Pos[1];
        P2c=Pos[2];
        P2r=Pos[3];
        
        //game_matrix[P1r][P1c]=!game_matrix[P1r][P1c];
        //game_matrix[P2r][P2c]=!game_matrix[P2r][P2c];
        p1_row_d = (P1r - escR);// 2 - 7 = -5
        p1_col_d = (P1c - escC);// 3 - 8 = -5
        
//    //  player 2 distance to ep:
        p2_row_d = (P2r - escR);// 4 - 7 = -3
        p2_col_d = (P2c - escC);// 6 - 8 = -2
        
        
        if(p1_row_d < 0) p1_row_d = -p1_row_d;
        if(p1_col_d < 0) p1_col_d = -p1_col_d;
        if(p2_row_d < 0) p2_row_d = -p2_row_d;
        if(p2_col_d < 0) p2_col_d = -p2_col_d;
//    //7 segment display the number:
        num_display = p2_col_d + 100*(p2_row_d) + 10000*(p1_col_d) + 1000000*(p1_row_d);
        
        for (i = 0; i < 16; i = i + 1)//turn off all LEDs
            for (j = 0; j < 24; j = j + 1)
                Vision[i][j] = 0;
          
          for( i=P1r-1; i<=P1r+1; i = i + 1 ) begin
		      for( j=P1c-1; j<=P1c+1; j = j + 1 ) begin
			     if (i>=0 & j>=0 & i<16 & j<24) begin
			         Vision[i][j] = game_matrix[i][j];
			     end
			  end
		  end
		  for( i=P2r-1; i<=P2r+1; i = i + 1 ) begin
		      for( j=P2c-1; j<=P2c+1; j = j + 1 ) begin
			     if (i>=0 & j>=0 & i<16 & j<24) begin
			         Vision[i][j] = game_matrix[i][j];
			     end
			  end
		  end
		  
		  if (victory ==1) begin
		        for (i = 0; i < 16; i = i + 1)//turn off all LEDs
                    for (j = 0; j < 24; j = j + 1)
                        game_matrix[i][j] = 0;
                for (i = 3; i <= 12; i = i + 1)
                    game_matrix[i][5]=1;
                for (i = 6; i <= 11; i = i + 1)
                    game_matrix[3][i]=1;
                for (i = 4; i <= 7; i = i+1)
                    game_matrix[i][11]=1;
                for (i = 6; i <= 10; i = i+1)
                    game_matrix[7][i]=1;
                for(i=3;i<=12;i=i+1)
                    game_matrix[i][15]=1;
                for (i = 0; i < 16; i = i + 1)
                    for (j = 0; j < 24; j = j + 1)
                         Vision[i][j] = game_matrix[i][j];
           end
           if (victory ==2) begin
               for (i = 0; i < 16; i = i + 1)//turn off all LEDs
                    for (j = 0; j < 24; j = j + 1)
                        game_matrix[i][j] = 0;
               for (i = 3; i <= 12; i = i + 1)
                    game_matrix[i][5]=1;
               for (i = 6; i <= 11; i = i + 1)
                    game_matrix[3][i]=1;
               for (i = 4; i <= 7; i = i+1)
                    game_matrix[i][11]=1;
               for (i = 6; i <= 10; i = i+1)
                    game_matrix[7][i]=1;
        
               for (i = 15; i <= 21; i = i+1)
                    game_matrix[3][i]=1;
               for (i = 3; i <= 7; i = i+1)
                    game_matrix[i][21]=1;
                for (i = 15; i <= 21; i = i+1)
                    game_matrix[7][i]=1;
                for (i = 7; i <= 12; i = i+1)
                    game_matrix[i][15]=1;
                for (i = 15; i <= 21; i = i+1)
                    game_matrix[12][i]=1;        
           end
		  
		  
        $display("Vision:");
		for( i=0; i<16; i = i + 1 ) begin
			for( j=0; j<24; j = j + 1 ) begin
				$write("%D ", Vision[i][j]);
			end
			$write("\n");
		end
		
        $display("game_matrix:");
		for( i=0; i<16; i = i + 1 ) begin
			for( j=0; j<24; j = j + 1 ) begin
				$write("%D ", game_matrix[i][j]);
			end
			$write("\n");
		end
		  
    end
    
//        if ((P1c-2)>=0 & (P1r-2)>=0) begin
//            matrix_to_send[Pos[1]][Pos[0]] = game_matrix[P1r-2][P1c-2];
//        end
//        if ((P1c-1)>=0 & (P1r-2)>=0) begin
//            matrix_to_send[Pos[1]][Pos[0]] = game_matrix[P1r-2][P1c-1];
//        end
//        if ((P1c-1)>=0 & (P1r-2)>=0) begin
//            matrix_to_send[Pos[1]][Pos[0]] = game_matrix[P1r-2][P1c];
//        end
//        if ((P1c-1)>=0 & (P1r-2)>=0) begin
//            matrix_to_send[Pos[1]][Pos[0]] = game_matrix[Pos[1]-2][Pos[0]-2];
//        end
//        if (([Pos[1]-2)>=0) begin
//            matrix_to_send[Pos[1]][Pos[0]] = game_matrix[Pos[1]-2][Pos[0]-2];
//        end
//        if (([Pos[1]-2)>=0) begin
//            matrix_to_send[Pos[1]][Pos[0]] = game_matrix[Pos[1]-2][Pos[0]-2];
//        end
endmodule