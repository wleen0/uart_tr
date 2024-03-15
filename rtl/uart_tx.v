module uart_tx(
    input       clk,
    input       reset,
    input [7:0] uart_tx_data,
    output reg  uart_txd
);
wire parity;
reg [7:0]  tx_data_temp;
reg uart_tx_busy;
reg [15:0] baud_cnt;
reg [3:0]  tx_cnt;
parameter  clk_freq = 50000000;
parameter  uart_bps = 115200;
parameter  baud_cnt_max = clk_freq/uart_bps;

// uart_tx_data register
always @(posedge clk or posedge reset) begin
    if(reset)
        tx_data_temp <= 8'd0;
    else
        tx_data_temp <= (tx_cnt <= 9) ? uart_tx_data : 8'd0;
end

// Counting Baud rate
always @(posedge clk or posedge reset) begin
    if(reset)
        baud_cnt <= 16'b0;
    else
        baud_cnt <= (uart_tx_busy && (baud_cnt < baud_cnt_max - 16'd1)) ? baud_cnt + 16'd1 : 16'd0;
end

// Define tx_cnt
always @(posedge clk or posedge reset) begin
    if(reset)
        tx_cnt <= 4'b0;
    else 
        tx_cnt <= (baud_cnt == baud_cnt_max - 4'd1) ? tx_cnt + 4'd1 : tx_cnt;
end


// transmission proceeds?
always @(posedge clk or posedge reset) begin
    if(reset) 
        uart_tx_busy <= 1'b0;
    else if (baud_cnt == baud_cnt_max/2-1'b1 && tx_cnt == 4'd10)
        uart_tx_busy <= 1'b0;
    else if(tx_cnt <=9)
        uart_tx_busy <= 1'b1;
    else
        uart_tx_busy <= uart_tx_busy;
end

assign parity = ^uart_tx_data;

always @(posedge clk or posedge reset) begin
    if(reset)
        uart_txd <= 1'b1;
    else if(uart_tx_busy) begin
        case(tx_cnt)
            4'd0: uart_txd <= 1'b0;             //start bit
            4'd1: uart_txd <= tx_data_temp[0];
            4'd2: uart_txd <= tx_data_temp[1];
            4'd3: uart_txd <= tx_data_temp[2];
            4'd4: uart_txd <= tx_data_temp[3];
            4'd5: uart_txd <= tx_data_temp[4];
            4'd6: uart_txd <= tx_data_temp[5];
            4'd7: uart_txd <= tx_data_temp[6];
            4'd8: uart_txd <= tx_data_temp[7];
            4'd9: uart_txd <= parity;            //parity bit
            4'd10: uart_txd <= 1'b1;            //stop bit
            default: ;
        endcase
    end
    else
        uart_txd <= 1'b1;
end
endmodule