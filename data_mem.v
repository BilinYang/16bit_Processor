`timescale 1ns/1ns

/**
 * Module: data_mem
 * 
 * The simplified data memory model for the processor.
 */
module data_mem(
	input 		  clk_pi, // 100 MHz clk
	input 		  clk_en_pi, // clock enable
	input 		  reset_pi, // synchronous reset
	
	input 		  write_pi, // write enable signal
	input [15:0] 	  wdata_pi, // write data
	input [15:0] 	  addr_pi, // memory address
	output reg [15:0] rdata_po, // data read from data memory		 	
	output reg [15:0] display_num_po // NEW for FPGA: data to display
 );
	

   reg [7:0] 		  DATA_MEM[0 : 255]; // 256 byte memory

   always @(*) 
	   rdata_po =  {DATA_MEM[addr_pi[7:0]],DATA_MEM[addr_pi[7:0]+1]};
	   
   

integer i;
   
   always @(posedge clk_pi) begin
      if (reset_pi) begin
	 for (i=0; i < 128; i = i+2) begin
	    DATA_MEM[i] <= {8'hFA, 8'hFA};  // Initialize DATA_MEM to FA
	   end
	 display_num_po <= 16'hABAB; 
      end 
		
// if ST address is  0x9000 output write data to 7-segment display; else write to specified MEM address

      else if (write_pi && clk_en_pi) begin		
	 case (addr_pi)
	   16'h9000: display_num_po <= wdata_pi;
	   default: {DATA_MEM[addr_pi[7:0]],DATA_MEM[addr_pi[7:0]+1]} <= wdata_pi;
	   endcase
      end
   end
endmodule

