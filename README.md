# 16-Bit RISC Processor (Boolean Board)

A custom 16-bit soft-core processor implemented in Verilog, designed specifically for the **Real Digital Boolean FPGA Board** (Xilinx Spartan-7). 

This project implements a Harvard Architecture CPU capable of executing a custom Instruction Set Architecture (ISA), featuring arithmetic operations, logic control, and memory-mapped I/O to drive the board's 7-segment displays.

## 🚀 Project Overview

* **Architecture:** 16-bit Harvard Architecture (Separate Instruction and Data Memory).
* **Target Hardware:** Real Digital Boolean Board (XC7S50-CSGA324).
* **Toolchain:** Xilinx Vivado (Synthesis & Simulation).
* **Clock Speed:** 100MHz (Internal logic), scaled down for display drivers.

## ✨ Key Features

* **Custom ISA:** 16-bit instruction width supporting Arithmetic, Logical, Memory, and Control Flow operations.
* **Memory Mapped I/O:** Dedicated memory addresses trigger hardware outputs. Writing to address `0x9000` allows software to drive the on-board 7-segment display.
* **Branching Logic:** Supports conditional branching (`BEQ`, `BLE`, `BGE`) and unconditional jumps.
* **Hardware Integration:** Fully constrained (`.xdc`) to utilize the Boolean board's LEDs, Switches, and 7-Segment Display.

## 📂 Repository Structure

| File | Description |
| :--- | :--- |
| **processor.v** | Top-level module interconnecting the Datapath, Control Unit, and Memory. |
| **alu.v** | Arithmetic Logic Unit. Handles ADD, SUB, AND, OR, XOR, SHIFT operations. |
| **decoder.v** | Decodes the 16-bit opcode into control signals for the datapath. |
| **program_counter.v** | Manages instruction fetching, branch offsets, and jumps. |
| **data_mem.v** | 256-byte Data RAM. Includes logic for Memory Mapped I/O (Display). |
| **instruction_mem.v** | ROM containing the assembly binary. **Includes 3 selectable test programs.** |
| **display.v** | Driver for the multiplexed 4-digit 7-segment display. |
| **branch.v** | Comparator logic for handling conditional branch evaluation. |
| **boolean.xdc** | Xilinx Design Constraints file mapping ports to FPGA pins. |

## ⚙️ Architecture & ISA

The processor uses a fixed-length 16-bit instruction format. The opcode typically occupies the upper 4 bits.

### Instruction Set Summary
| Opcode | Mnemonic | Description |
| :--- | :--- | :--- |
| `0001` | **ARITH** | Register-Register Arithmetic (ADD, SUB, AND, OR, XOR) |
| `0011` | **MOVI** | Move Immediate (Load 8-bit constant to register) |
| `0100` | **ADDI** | Add Immediate |
| `0110` | **LOAD** | Load Word from Memory |
| `0111` | **STOR** | Store Word to Memory |
| `1000` | **BEQ** | Branch if Equal |
| `1100` | **JUMP** | Unconditional Jump |
| `1111` | **HALT** | Stop execution |

### Memory Map
* **0x0000 - 0x00FF**: General Purpose Data Memory (RAM).
* **0x9000**: **Display Output Register**. Values written here appear on the 7-segment display.

## 📝 Running Test Programs

The `instruction_mem.v` file comes pre-loaded with **three different assembly programs**. By default, **Test 1** is active. 

To run a different program, open `instruction_mem.v` and move the comment blocks (`/* ... */`) to enable the desired `case` statements.

### 1. Display I/O Test (Default)
A simple verification program that writes the hexadecimal value `0xBEEF` to the display.
* **Goal:** Verify the Memory Mapped I/O functionality.
* **Code:**
  ```verilog
  // MOVIL $7, 0x0   (Set $7 to 0x0000)
  // MOVIH $7, 0x90  (Set $7 to 0x9000 - Display Address)
  // MOVIH $1, 0xBE  (Load 0xBE into upper byte)
  // MOVIL $1, 0xEF  (Load 0xEF into lower byte -> 0xBEEF)
  // STOR  $1, 0($7) (Write 0xBEEF to Display)
  // HALT
