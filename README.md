# UART Transceiver in Verilog

## Overview

This repository contains the implementation of a UART (Universal Asynchronous Receiver/Transmitter) transceiver in Verilog. The transceiver supports both transmission and reception of serial data. It includes a baud rate generator, a UART receiver, and a UART transmitter.

## Features

- **Baud Rate Generator**: Generates the required clock ticks for the specified baud rate.
- **UART Receiver**: Receives serial data and outputs the received byte.
- **UART Transmitter**: Transmits serial data based on the input byte.
- **Configurable**: Supports different clock rates, baud rates, and oversampling rates.

## Files

- `baudRateGenerator.v`: Module for generating the baud rate clock ticks.
- `uart_rx_controller.v`: Module for receiving serial data.
- `uart_tx_controller.v`: Module for transmitting serial data.
- `uart_controller.v`: Top-level module that integrates the baud rate generator, receiver, and transmitter.

## Module Descriptions

### `baudRateGenerator`

This module generates the clock ticks required for the UART receiver and transmitter based on the specified clock rate and baud rate.

**Parameters:**
- `CLOCK_RATE`: The clock rate of the system.
- `BAUD_RATE`: The desired baud rate for UART communication.
- `RX_OVERSAMPLE`: The oversampling rate for the receiver.

### `uart_rx_controller`

This module handles the reception of serial data. It detects the start bit, reads the data bits, and detects the stop bit.

### `uart_tx_controller`

This module handles the transmission of serial data. It sends the start bit, data bits, and stop bit.

### `uart_controller`

This is the top-level module that instantiates the baud rate generator, receiver, and transmitter modules. It can be configured to support only transmission, only reception, or both.

## Usage

1. **Instantiate the `uart_controller` module** in your top-level design.
2. **Configure the parameters** (`CLOCK_RATE`, `BAUD_RATE`, `RX_OVERSAMPLE`) as needed.
3. **Connect the signals** (`clk`, `reset_n`, `i_Tx_Ready`, `i_Tx_Byte`, `i_Rx_Data`, `o_Tx_Active`, `o_Tx_Done`, `o_Rx_Done`, `o_Rx_Byte`, `o_Tx_Data`).

### Example Instantiation

```verilog
uart_controller #(
    .CLOCK_RATE(25000000),
    .BAUD_RATE(115200),
    .RX_OVERSAMPLE(16)
) uart_inst (
    .clk(clk),
    .reset_n(reset_n),
    .i_Tx_Ready(i_Tx_Ready),
    .i_Tx_Byte(i_Tx_Byte),
    .i_Rx_Data(i_Rx_Data),
    .o_Tx_Active(o_Tx_Active),
    .o_Tx_Done(o_Tx_Done),
    .o_Rx_Done(o_Rx_Done),
    .o_Rx_Byte(o_Rx_Byte),
    .o_Tx_Data(o_Tx_Data)
);
```
###Results The performance and correctness of the UART transceiver can be verified through simulation. Below is an example waveform and output demonstrating the operation of the UART transceiver:
![image](https://github.com/user-attachments/assets/91b5162c-6a54-4e3c-b2dd-b8a5e14ed263)


![result](https://github.com/user-attachments/assets/b43965e2-0431-446e-9f6a-15810eb70bcf)

