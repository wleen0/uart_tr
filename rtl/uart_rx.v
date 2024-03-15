module uart_rx(
    input            clk,
    input            reset,
    input            uart_rxd,
    output reg [7:0] uart_rx_data
);
reg        uart_rxd_s0;
reg        uart_rxd_s1;
reg        uart_rxd_s2;
reg        rx_flag;
reg        uart_rx_done;
reg [15:0] baud_cnt; // 16'd65535 lowest baud rate: 762
reg [3:0]  rx_cnt;
reg [8:0]  rx_data_temp;
wire       start_en;
parameter  clk_freq = 50000000;
parameter  uart_bps = 115200;
parameter  baud_cnt_max = clk_freq/uart_bps; 

// uart_rxd signal delay three clock cycles
always @(posedge clk or posedge reset) begin
    if(reset) begin
        uart_rxd_s0 <= 1'b0;
        uart_rxd_s1 <= 1'b0;
        uart_rxd_s2 <= 1'b0;
    end
    else begin
        uart_rxd_s0 <= uart_rxd;
        uart_rxd_s1 <= uart_rxd_s0;
        uart_rxd_s2 <= uart_rxd_s1;
    end
end

// Define the negative edge of uart_rxd
assign start_en = ((~uart_rxd_s1 & uart_rxd_s2) & ~rx_flag) ? 1'b1 : 1'b0;

// start recieving data flag
always @(posedge clk or posedge reset) begin
    if(reset)
        rx_flag <= 1'b0;
    else if(start_en)
        rx_flag <= 1'b1;
    else
        rx_flag <= (baud_cnt == baud_cnt_max/2-1'b1 && rx_cnt== 4'd10) ? 1'b0 : rx_flag;
end

// Counting Baud rate
always @(posedge clk or posedge reset) begin
    if(reset)
        baud_cnt <= 16'b0;
    else
        baud_cnt <= (rx_flag && (baud_cnt < baud_cnt_max - 1'b1)) ? baud_cnt + 16'd1 : 16'd0;
end

// Counting each bit of data
always @(posedge clk or posedge reset) begin
    if(reset)
        rx_cnt <= 4'b0;
    else if(rx_flag)
        rx_cnt <= (baud_cnt == baud_cnt_max - 1'b1) ? rx_cnt + 4'd1 : rx_cnt;
    else
        rx_cnt <= 4'd0;
end

// Read data into the register and parity check
always @(posedge clk or posedge reset) begin
    if(reset) begin
        rx_data_temp <= 8'b0;
    end
    else if(rx_flag) begin
        if(baud_cnt == baud_cnt_max/2-1'b1 && rx_cnt <= 9) begin
            rx_data_temp <= {uart_rxd_s2, rx_data_temp[8:1]};
        end
        else if(baud_cnt == baud_cnt_max/2-1'b1 && rx_cnt == 10 && rx_data_temp[8]==1)
            rx_data_temp <= 9'd0;
        else
            rx_data_temp <= rx_data_temp;
        end
    else begin
        rx_data_temp <= 8'b0;
    end
end

// Finish data receiving
always @(posedge clk or posedge reset) begin
    if(reset)
        uart_rx_done <= 1'b0;
    else if(baud_cnt == baud_cnt_max/2-1'b1 && rx_cnt == 4'd10 && rx_data_temp[8]==0)
        uart_rx_done <= 1'b1;
    else
        uart_rx_done <= 1'b0;        
end

// Received data transfer to rx_data
always @(posedge clk or posedge reset) begin
    if(reset)
        uart_rx_data <= 8'b0;
    else if(baud_cnt == baud_cnt_max/2-1'b1 && rx_cnt == 4'd10 && rx_data_temp[8]==0)
        uart_rx_data <= rx_data_temp;
    else
        uart_rx_data <= uart_rx_data;
end
endmodule