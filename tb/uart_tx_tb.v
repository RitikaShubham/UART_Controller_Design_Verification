module uart_tx_tb;

reg clk;
reg rst;
reg tx_start;
reg [7:0] tx_data;

wire tx;
wire tx_busy;

uart_tx uut (
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx(tx),
    .tx_busy(tx_busy)
);

// Clock generation
always #5 clk = ~clk;

// Stimulus
initial begin
    clk = 0;
    rst = 1;
    tx_start = 0;
    tx_data = 8'b10110010;

    #10;
    rst = 0;

    #10;
    tx_start = 1;

    #10;
    tx_start = 0;

    #200;
    $finish;
end

// Dump waveform
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, uart_tx_tb);
end

endmodule