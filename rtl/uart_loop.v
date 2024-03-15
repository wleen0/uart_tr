module uart_loop(
    input        clk,
    input        reset,
    input  [7:0] uart_txd,      //uart transmit data
    output [7:0] uart_rx_data   //uart received data
);

parameter  clk_freq = 50000000;
parameter  uart_bps = 115200;
wire uart_tx_data;

uart_tx #(.clk_freq(clk_freq), .uart_bps(uart_bps))
    in_uart_tx(
    .clk(clk),
    .reset(reset),
    .uart_tx_data(uart_txd),
    .uart_txd(uart_tx_data)
    );

uart_rx #(.clk_freq(clk_freq), .uart_bps(uart_bps))
    in_uart_rx(
    .clk(clk),
    .reset(reset),
    .uart_rxd(uart_tx_data),
    .uart_rx_data(uart_rx_data)
);
endmodule
