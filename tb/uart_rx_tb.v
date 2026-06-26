module uart_rx_tb;

reg clk;
reg rst;
reg rx;
reg baud_tick;

wire [7:0] rx_data;
wire rx_done;

// Instantiate UART Receiver
uart_rx uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .baud_tick(baud_tick),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

// Clock generation
always #5 clk = ~clk;

// Test stimulus
initial begin

    // Initial values
    clk = 0;
    rst = 1;
    rx = 1;          // idle state
    baud_tick = 0;

    // Release reset
    #10 rst = 0;

   
    // Start bit

    rx = 0;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    
    // bit0 = 0
    rx = 0;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    // bit1 = 1
    rx = 1;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    // bit2 = 0
    rx = 0;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    // bit3 = 0
    rx = 0;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    // bit4 = 1
    rx = 1;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    // bit5 = 1
    rx = 1;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    // bit6 = 0
    rx = 0;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    // bit7 = 1
    rx = 1;
    #10 baud_tick = 1;
    #10 baud_tick = 0;

    
    // Stop bit
    rx = 1;
    #10 baud_tick = 1;
    #10 baud_tick = 0;
    #100;
    $finish;

end

// Dump waveform
initial begin
    $dumpfile("rx_dump.vcd");
    $dumpvars(0, uart_rx_tb);
end

initial begin
    $dumpfile("rx_dump.vcd");
    $dumpvars(0, uart_rx_tb);
end

// -------------------------
// Debug Monitor
// -------------------------
always @(posedge clk) begin
    $display(
        "Time=%0t  State=%0d  RX=%b  ShiftReg=%b  BitCount=%0d  RX_Data=%b  RX_Done=%b",
        $time,
        uut.state,
        rx,
        uut.shift_reg,
        uut.bit_count,
        rx_data,
        rx_done
    );
end

endmodule
