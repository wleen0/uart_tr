# uart_tr
Let's get started to know how UART works. UART is commonly used for the communication between a microcontroller and a PC. At first, the transmitting UART receives parallel data from the data bus. Before transmitting the data bit-by-bit to the receiving UART, the data is generally added with a start bit, parity bit and stop bit. Since the receiving UART reads the serial data, it converts the data into a parallel form, excluding the start bit, parity bit and stop bit, before sending it to the data bus.
![GITHUB](https://github.com/wleen0/uart_tr/blob/main/imgs/uart_communicate.png?raw=true)
# Source files
**_`uart_tx`_ module**  
As mentioned above, the transmitting UART not only transmits the data bits, but also adds the start bit, parity bit and stop bit in the form of a packet. Furthermore, specifying the maximum number of `baud_cnt` counter to define the baud rate is essential before transferring data.

**_`uart_rx`_ module**  
Due to the fact that the data packet is transferred asynchronously to the UART on the receiver device, there is a need to delay the `uart_rxd` signal for a few clock cycles, known as serial packets, to avoid metastability.

# Reference
* https://www.seeedstudio.com/blog/2022/09/08/uart-communication-protocol-and-how-it-works/
* https://blog.csdn.net/weixin_55796564/article/details/122307636  
* https://www.totalphase.com/blog/2021/12/i2c-vs-spi-vs-uart-introduction-and-comparison-similarities-differences/
* https://www.linkedin.com/advice/1/what-best-practices-avoid-metastability-issues-cross-clock
