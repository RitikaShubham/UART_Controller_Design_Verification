module uart_rx(

    input clk,
    input rst,
    input rx,
    input baud_tick,

    output reg [7:0] rx_data,
    output reg rx_done

);
parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

reg [1:0] state;
reg [2:0] bit_count;
reg [7:0] shift_reg;

always @(posedge clk)
if(rst)


begin
    state <= IDLE;
    bit_count <= 0;
    shift_reg <= 0;
    rx_data <= 0;
    rx_done <= 0;
end

else begin

    if(state == IDLE)
    begin
        rx_done <= 1'b0;

        if(rx == 1'b0)
        begin
            bit_count <= 0;
            state <= START;
        end
    end

    if(state == START)
begin
    if(baud_tick)
        state <= DATA;
end

if(state == DATA)
begin
    if(baud_tick)
    begin

        shift_reg <= {rx, shift_reg[7:1]};

        if(bit_count == 7)
            state <= STOP;
        else
            bit_count <= bit_count + 1;

    end
end

if(state == STOP)
begin

    if(baud_tick)
    begin

        rx_data <= shift_reg;
        rx_done <= 1'b1;

        state <= IDLE;

    end

end

end

endmodule

