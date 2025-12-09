`timescale 1ns/1ns

/* 
 * Module: segmentFormatter
 * 
 * Description: Combinational logic for the seven segment bits of a digit of the seven segment display
 *
 * 0 - LSB of disp_po
 * 6 - MSB of disp_po
 *      --(0)   
 * (5)|      |(1)
 *      --(6)
 * (4)|      |(2)
 *      --(3) 
 * 
 * disp_po is active low 
 */
module segmentFormatter(
    input enable, 
    input [3:0] num_pi,
    output reg [6:0] disp_po
);
	always @(*) begin
	    if (enable) begin
		case(num_pi)
			4'h0: disp_po = 7'b1000000;
			4'h1: disp_po = 7'b1111001;
			4'h2: disp_po = 7'b0100100;
			4'h3: disp_po = 7'b0110000;
			4'h4: disp_po = 7'b0011001;
			4'h5: disp_po = 7'b0010010;
			4'h6: disp_po = 7'b0000010;
			4'h7: disp_po = 7'b1111000;
			4'h8: disp_po = 7'b0000000;
			4'h9: disp_po = 7'b0010000;
			4'hA: disp_po = 7'b0001000;
			4'hB: disp_po = 7'b0000011;
			4'hC: disp_po = 7'b1000110;
			4'hD: disp_po = 7'b0100001;
			4'hE: disp_po = 7'b0000110;
			4'hF: disp_po = 7'b0001110;
		endcase
		end
		else
		  disp_po = 7'b1111111; 
	end
endmodule // segmentFormatter

/*
 * Module: sevenSegDisplay
 * Description: Formats an input 16 bit number for the four digit seven-segment display
 */
module sevenSegDisplay(
	input clk_pi,
	input clk_en_pi,
	input[15:0] num_pi,
	output reg [6:0] seg_po,
	output reg [3:0] an_po
);
	
	wire [6:0] disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7;
		
	segmentFormatter IsegmentFormat0 (.enable(1'b1),  .num_pi(num_pi[3:0]),   .disp_po(disp0));
	segmentFormatter IsegmentFormat1 (.enable(1'b1),  .num_pi(num_pi[7:4]),   .disp_po(disp1));
	segmentFormatter IsegmentFormat2 (.enable(1'b1),  .num_pi(num_pi[11:8]),  .disp_po(disp2));
	segmentFormatter IsegmentFormat3 (.enable(1'b1),  .num_pi(num_pi[15:12]), .disp_po(disp3));
		
	initial begin
		seg_po <= 7'h7F;
		an_po <= 4'b1111;
	end
	
	always @(posedge clk_pi) begin
		if(clk_en_pi) begin
		
	       case(an_po) 
                4'b1110: begin
            	   seg_po <= disp1;
            	   an_po  <= 8'b1101;
                end
                4'b1101: begin
                   seg_po <= disp2;
            	   an_po  <= 8'b1011;
                end
                4'b1011: begin
        	    seg_po <= disp3;
        	    an_po  <= 8'b0111;
                end
		default: begin
            	    seg_po <= disp0;
            	    an_po <= 8'b1110;
		end
		endcase
	
		end // clk_en
	end // always @(posedge clk_pi)
endmodule // sevenSegDisplay
