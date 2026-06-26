module uart_loopback(

    input clk,
    input rst,

    input tx_start,
    input [7:0] tx_data,

    output [7:0] rx_data,
    output rx_done,
    output tx_busy

);

wire baud_tick;
wire tx_line;


baud_generator bg(

    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick)

);

// UART Transmitter
uart_tx tx(

    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .baud_tick(baud_tick),
    .tx_data(tx_data),

    .tx(tx_line),
    .tx_busy(tx_busy)

);

// UART Receiver
uart_rx rx(

    .clk(clk),
    .rst(rst),
    .rx(tx_line),          // Connect TX output to RX input
    .baud_tick(baud_tick),

    .rx_data(rx_data),
    .rx_done(rx_done)

);

endmodule
