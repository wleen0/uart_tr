# uart_tr
Let's get started to know the procedure of UART communication. At first, the transmitting UART receives parallel data from the data bus. Before transmitting the data bit-by-bit to the receiving UART, the data is generally added with a start bit, parity bit and stop bit. Since the 


 the transmitting UART, receives parallel data from the CPU (microprocessor or microcontroller) and converts it to serial data. This serial data is transmitted to the UART on the receiver device, or the receiving UART. The receiving UART converts the received serial data back to parallel data and sends it to the CPU. In order for UART to convert serial-to-parallel and parallel-to-serial data, shift registers on the transmitting and receiving UART are used.

In UART communication, only two wires are required for communication: data flows from the Tx pin of the transmitting UART (Transmitter Tx) to the Rx pin of the receiving UART (Receiver Rx).
UART data is sent over the bus in the form of a packet. A packet consists of a start bit, data frame, a parity bit, and stop bits. The parity bit is used as an error check mechanism to help ensure data integrity.
