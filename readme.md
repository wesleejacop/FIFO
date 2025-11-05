# FIFO Verilog Module

## Overview
This project implements a FIFO (First-In, First-Out) memory buffer module in Verilog, along with a testbench to verify its functionality. The FIFO supports 8-bit data input/output with a depth of 64 entries. It features full and empty flags and a counter indicating the current number of stored elements.

## Features
- 8-bit wide data input and output
- 64-depth FIFO buffer
- Write enable (`wr_en`) and read enable (`rd_en`) control signals
- FIFO full and empty indication flags (`buf_full`, `buf_empty`)
- Real-time counter of stored elements (`fifo_counter`)

## Files
- `FIFO.v`: Verilog source code of the FIFO module
- `tb_FIFO.v`: Testbench for the FIFO module to simulate and verify operation

## Tools Used
- Icarus Verilog (`iverilog`)
- GTKWave waveform viewer

## How to Run Simulation

1. Compile the design:

     iverilog -o fifo_tb.vvp tb_FIFO.v FIFO.v


2. Run the simulation:

    vvp fifo_tb.vvp

3. View the waveform:

   gtkwave fifo_waveform.vcd


## Description

The FIFO module supports asynchronous reset, simultaneous read/write operations, and outputs status flags and a counter to track FIFO usage.

The testbench writes data, reads data, performs simultaneous read/write cycles, and monitors the internal state through simulation.

## Signal Behavior Overview

- **clk**: Clock toggles every 5 ns (10 ns period).
- **rst**: Active high reset initializes FIFO state.
- **wr_en**: Enable writing input data into FIFO if not full.
- **rd_en**: Enable reading data from FIFO if not empty.
- **buf_in**: Data input bus.
- **buf_out**: Data output bus reflects data at read pointer.
- **buf_empty**: Asserted when FIFO is empty.
- **buf_full**: Asserted when FIFO is full.
- **fifo_counter**: Counts number of data entries currently in FIFO.

## Simulation Test Sequence

- Initially reset FIFO.
- Write four data bytes sequentially.
- Read two bytes.
- Write and read two bytes simultaneously.
- Read out remaining data.
- Monitor signals during the sequence logged to console.




