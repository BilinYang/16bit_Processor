`timescale 1ns/1ns
   
/*
  * Module: display_clkdiv
 *  * Description: Generates a clk_en signal that reduces the clock frequency for the display.
 *     The seven segment display is not particularly visible with the full 100Mhz clock.
 *  
 *  * Parameterized to experiment with different clock frequencies for the display 
 * */

module display_clkdiv (
       input  clk_pi,
       output clk_en_po
);
   parameter SIZE = 10;
   reg [SIZE-1:0] counter;

   initial begin
      counter <= 0;
   end

   always @(posedge clk_pi) begin
      counter = counter + 1;
   end
   assign clk_en_po = (counter == {SIZE{1'b0}});
   
endmodule // display_clkdiv

