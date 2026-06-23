module uart_top(

    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,

    output tx,
    output tx_busy

);

wire baud_tick;

baud_generator bg(

    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick)

);

uart_tx tx1(

    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .baud_tick(baud_tick),
    .tx_data(tx_data),
    .tx(tx),
    .tx_busy(tx_busy)

);

endmodule