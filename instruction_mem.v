`timescale 1ns / 1ps

 /**
 * Module: instruction_mem
 * 
 * The instruction memory model for the processor.
 * 
 */

module instruction_mem(
	input [15:0] pc_pi,
	output[15:0] instruction_po
      );

   reg [15:0] 		  instruction;

   assign instruction_po = instruction;

   
   always @(pc_pi) begin  
   case(pc_pi)	     

// TEST 1 PROGRAM (test1.asm)

         0: instruction = 16'b0011111000000000;  // MOVIL $7, 0x0  : Set $7 to 0x9000
         2: instruction = 16'b0011111110010000;  // MOVIH $7, 0x90 : Address of DISPLAY
         4: instruction = 16'b0011001110111110;  // MOVIH $1, 0xBE : Set $1 to 0xBEEF
         6: instruction = 16'b0011001011101111;  // MOVIL $1, 0xEF : Value to display
         8: instruction = 16'b0111001111000000;  // ST $1, 0($7)   : Store $1 to DISPLAY
        10: instruction = 16'b1111111111111111;  // HALT



// TEST 2 PROGRAM (Array Sum) (test2.asm)
/*
      0: instruction = 16'b0011111000000000;  // MOVIL $7, 0x0  : Set $7 to 0x9000
      2: instruction = 16'b0011111110010000;  // MOVIH $7, 0x90 : Address of DISPLAY
      4: instruction = 16'b0011000000000100;  // MOVIL $0, 4
      6: instruction = 16'b0011001000000000;  // MOVIL $1, 0
      8: instruction = 16'b0011010001000000;  // MOVIL $2, 0x40
     10: instruction = 16'b0100001001000001;  // LOOP1:  ADDI $1, $1, 1
     12: instruction = 16'b0111001010000000;  // ST   $1, 0($2)
     14: instruction = 16'b0100010010000010;  // ADDI $2, $2, 2
     16: instruction = 16'b1010001000111000;  // BLE  $1, $0, LOOP1
     18: instruction = 16'b0011001000000000;  // MOVIL   $1, 0
     20: instruction = 16'b0011100000000000;  // MOVIL   $4, 0
     22: instruction = 16'b0011010001000000;  // MOVIL   $2, 0x40
     24: instruction = 16'b0110011010000000;  // LOOP2:  LD $3, 0($2)
     26: instruction = 16'b0001100100011000;  // ADD  $4, $4, $3
     28: instruction = 16'b0100010010000010;  // ADDI $2, $2, 2
     30: instruction = 16'b0100001001000001;  // ADDI $1, $1, 1
     32: instruction = 16'b1010001000110110;  // BLE  $1, $0, LOOP2
     34: instruction = 16'b0111100111000000;  // SD $4, 0($7)  // Store $4 to DISPLAY
     36: instruction = 16'b1111111111111111;  // HALT

  */   
 			
// TEST 3 PROGRAM (Fib) 
/*
     0:  instruction = 16'b0011111000000000;    // MOVIL $7, 0x0  : Set $7 to 0x9000
     2:  instruction = 16'b0011111110010000;    // MOVIH $7, 0x90 : Address of DISPLAY 
     4:  instruction = 16'b0011100000000000;    // MOVIL   $4, 0  
     6:  instruction = 16'b0011011000000001;    // MOVIL   $3, 1  
     8: instruction = 16'b0001010011100000;     // FIB:ADD $2 $3 $4
    10: instruction = 16'b1011000000001000;     //  BC END   
    12: instruction = 16'b0010100011000011;     //  CP $4 $3 
    14: instruction = 16'b0010011010000011;     //  CP $3 $2
    16: instruction = 16'b0111010111000000;     //  SD $2, 0($7): Store $2 to DISPLAY  
    18: instruction = 16'b1000000000110100;     //  BRA FIB
    20: instruction = 16'b1111111111111111;     //  END:  HALT
*/
default: instruction = 16'h0;
endcase
end
endmodule
