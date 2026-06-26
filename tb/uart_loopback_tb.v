module uart_loopback_tb;

reg clk;
reg rst;
reg tx_start;
reg [7:0] tx_data;

wire [7:0] rx_data;
wire rx_done;
wire tx_busy;

uart_loopback uut(

    .clk(clk),
    .rst(rst),

    .tx_start(tx_start),
    .tx_data(tx_data),

    .rx_data(rx_data),
    .rx_done(rx_done),
    .tx_busy(tx_busy)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    tx_start = 0;

    tx_data = 8'b10110010;

    #20;

    rst = 0;

    #20;

    tx_start = 1;

    #10;

    tx_start = 0;

    #2000;

    $finish;

end

initial begin

    $dumpfile("loopback.vcd");
    $dumpvars(0, uart_loopback_tb);

end

always @(posedge clk)
begin

    $display(
        "T=%0t count=%0d baud=%b TXstate=%0d bitcount=%0d shift=%b",
        $time,
        uut.bg.count,
        uut.baud_tick,
        uut.tx.state,
        uut.tx.bit_count,
        uut.tx.shift_reg
    );
end

endmodule