# Verilog Memory Designs

## Overview
This repository contains Verilog HDL implementations of commonly used memory blocks in digital systems.

The designs are written in a clean, modular manner and verified using dedicated testbenches.

## Included Designs

### 1. Single-Port Synchronous SRAM
- Read and write operations synchronized to clock
- Glitch-free output
- Suitable for FPGA/ASIC designs

### 2. Single-Port Asynchronous SRAM
- Read operation independent of clock
- Faster access time
- May cause output glitches

### 3. Dual-Port Asynchronous SRAM
- Two independent access ports
- Supports concurrent read/write operations

### 4. ROM (Single-Port Synchronous)
- Read-only memory
- Used for lookup tables and constants

## Folder Structure
SRAM_Single_Port_Synchronous/
SRAM_Single_Port_Asynchronous/
SRAM_Dual_Port_Asynchronous/
ROM_Single_Port_Synchronous/


## Tools Used
- Verilog HDL
- Xilinx Vivado (Simulation)

## Author
Shyam Prabhu

