# MIPS34 Processor with ANN Extension (VHDL)

## Overview

This project implements a **5-stage pipelined 32-bit Mini-MIPS processor (MIPS34-)** in VHDL, extended with a simple **Artificial Neural Network (ANN) instruction set**. The design demonstrates core computer architecture concepts including pipelining, hazard handling, and custom instruction extension.

---

## Architecture

The processor follows a standard **5-stage pipeline**:

- Instruction Fetch (IF)  
- Instruction Decode (ID)  
- Execute (EX)  
- Memory Access (MEM)  
- Write Back (WB)  

### Key Features
- 32-bit datapath  
- 32 general-purpose registers (R0 = 0)  
- Synchronous single-cycle memory  
- Forwarding unit for data hazards  
- Hazard detection unit  
- Custom ANN execution unit  
- Extra weight registers: W1, W2, W3  

---

## Instruction Set

### Standard Instructions
- ADD, SUB  
- ADDI, SUBI  
- AND, OR  
- LW, SW  
- BEQZ  

### ANN Extension Instructions
- **WGHT R1, R2, R3 → W1 = R1, W2 = R2, W3 = R3**  
- **ANN → Y = (W1×I1) + (W2×I2) + (W3×I3)**  

The ANN unit implements a **single-node neural computation** with weighted inputs and feedback capability.

---

## Pipeline Hazard Handling

- **Forwarding Unit** resolves RAW hazards between pipeline stages  
- **Hazard Detection Unit** handles load-use and stall conditions  
- Ensures correct execution of dependent instructions in a pipelined environment  

---

## Project Structure

### Phase 1 – ALU & Execution Unit
- Register file design  
- ALU + sign extension  
- Execute stage implementation  
- Individual testbenches for all modules  

### Phase 2 – Datapath & Memory
- IF, ID, MEM, WB stages  
- Pipeline registers  
- Synchronous memory block  
- Encryption/Decryption engine  
- Module-level testbenches  

### Phase 3 – Control & Integration
- FSM-based Control Unit  
- Forwarding and Hazard Detection Units  
- Full processor integration  
- Assembly test programs  
- System verification  

---

## Deliverables

- Complete VHDL source code  
- Individual testbenches for all modules  
- Fully integrated MIPS34 processor  
- Assembly test programs 

---

## Tools

- VHDL  
- FPGA simulation tools (Vivado)
---

## Notes

- Register R0 is hardwired to 0  
- Only LW and SW access memory  
- Memory is synchronous and single-cycle  
- All registers are 32-bit wide  

---
#Refenece Book

https://edisciplinas.usp.br/pluginfile.php/7910542/mod_resource/content/1/Digital%20Design%20and%20Computer%20Architecture.pdf
--
