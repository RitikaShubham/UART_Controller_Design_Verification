module uart_tx(
input clk,
input rst,
input tx_start,
input [7:0] tx_data,

output reg tx,
output reg tx_busy
);


parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

reg [1:0] state;
reg [2:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk) begin

    if (rst) begin
        state <= IDLE;
        bit_count <= 0;
        shift_reg <= 0;
        tx <= 1'b1;
        tx_busy <= 1'b0;
    end

    else begin

        if (state == IDLE) begin
            if (tx_start) begin
                shift_reg <= tx_data;
                bit_count <= 0;
                tx_busy <= 1'b1;
                state <= START;
            end
        end

        if (state == START) begin
            tx <= 1'b0;
            state <= DATA;
        end

        if (state == DATA) begin
            tx <= shift_reg[0];
            shift_reg <= shift_reg >> 1;

            if (bit_count == 7)
                state <= STOP;
            else
                bit_count <= bit_count + 1;
        end

        if (state == STOP) begin
            tx <= 1'b1;
            tx_busy <= 1'b0;
            state <= IDLE;
        end

    end

end
endmodule
    