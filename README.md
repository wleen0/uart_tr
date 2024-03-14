# uart_tr
Let's get started to know the procedure of UART communication. At first, the transmitting UART receives parallel data from the data bus. Before transmitting the data bit-by-bit to the receiving UART, the data is generally added with a start bit, parity bit and stop bit. Since the receiving UART reads the serial data, it converts the data into a parallel form, excluding the start bit, parity bit and stop bit, before sending it to the data bus.


