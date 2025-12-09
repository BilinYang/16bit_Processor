`timescale 1ns/1ns

module branch (
input        branch_eq_pi,
input        branch_ge_pi,
input        branch_le_pi,
input        branch_carry_pi,
input [15:0] reg1_data_pi,
input [15:0] reg2_data_pi,
input        alu_carry_bit_pi,

output  is_branch_taken_po)
;

assign is_branch_taken_po = ((branch_eq_pi && (reg1_data_pi==reg2_data_pi)) ||
                                (branch_ge_pi && (reg1_data_pi>=reg2_data_pi)) ||
                                (branch_le_pi && (reg1_data_pi<=reg2_data_pi)) ||
                                (branch_carry_pi && alu_carry_bit_pi)
                            );


endmodule // branch_comparator