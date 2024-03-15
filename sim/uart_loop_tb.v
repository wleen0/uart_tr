`timescale 1ns/1ns

module uart_loop_tb();
reg clk, reset;  
reg [7:0] uart_txd;
wire [7:0] uart_rx_data; 

parameter clk_period = 20;
uart_loop in_uart_loop( .clk(clk), .reset(reset), .uart_txd(uart_txd), .uart_rx_data(uart_rx_data));

initial begin
    clk = 1'b0;
    reset = 1'b1;
    uart_txd <= 8'h55;  // even parity
    #100
    reset = 1'b0;
    #100000
    reset = 1'b1;
    uart_txd <= 8'h57;  // odd parity
    #100
    reset = 1'b0;
end

always #(clk_period/2) clk = ~clk;
endmodule