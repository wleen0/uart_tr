# uart_tr
Let's get started to know how UART works. UART is commonly used for the communication between a microcontroller and a PC. At first, the transmitting UART receives parallel data from the data bus. Before transmitting the data bit-by-bit to the receiving UART, the data is generally added with a start bit, parity bit and stop bit. Since the receiving UART reads the serial data, it converts the data into a parallel form, excluding the start bit, parity bit and stop bit, before sending it to the data bus.


**_`de_bounce`_ module**  
Once the button is pushed, the metal parts inside the button begin to connect and disconnect several times. This causes the signal to bounce and transits multiple inputs as shown in the following figure.  
By generating the signal for debouncing, with the extra delay time set to avoid the bouncing periods.
![GITHUB](https://github.com/wleen0/uart_tr/blob/main/imgs/uart_communicate.png?raw=true)
