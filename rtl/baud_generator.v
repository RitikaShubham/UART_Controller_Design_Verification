module baud_generator(
    input clk,
    input rst,
    output reg baud_tick
);

parameter BAUD_DIV = 10;     // Small value for simulation

reg [15:0] count;

always @(posedge clk) begin

    if(rst) begin
        count <= 0;
        baud_tick <= 0;
    end

    else begin

        if(count == BAUD_DIV-1) begin
            count <= 0;
            baud_tick <= 1'b1;
        end

        else begin
            count <= count + 1;
            baud_tick <= 1'b0;
        end

    end

end

endmodule

