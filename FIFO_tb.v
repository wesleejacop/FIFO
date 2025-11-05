`include "FIFO.v"
module tb_FIFO;

reg clk, rst, wr_en, rd_en;
reg [7:0] buf_in;
wire [7:0] buf_out;
wire buf_empty, buf_full;
wire [7:0] fifo_counter;

// Instantiate FIFO
FIFO uut (
    .clk(clk),
    .rst(rst),
    .buf_in(buf_in),
    .buf_out(buf_out),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .buf_empty(buf_empty),
    .buf_full(buf_full),
    .fifo_counter(fifo_counter)
);

// Clock generation: 10ns period
initial clk = 0;
always #5 clk = ~clk;

initial begin
    // VCD dump commands
    $dumpfile("fifo_waveform.vcd");
    $dumpvars(0, tb_FIFO);
end

initial begin
    // Initialize inputs
    rst = 1; wr_en = 0; rd_en = 0; buf_in = 8'h00;
    #15;

    rst = 0;  // release reset

    // Write test: write 4 bytes
    wr_en = 1;
    buf_in = 8'hA1; #10;
    buf_in = 8'hB2; #10;
    buf_in = 8'hC3; #10;
    buf_in = 8'hD4; #10;
    wr_en = 0;

    // Read test: read 2 bytes
    rd_en = 1; #20;
    rd_en = 0;

    // Write and read simultaneously (to keep FIFO size steady)
    wr_en = 1; rd_en = 1;
    buf_in = 8'hE5; #10;
    buf_in = 8'hF6; #10;
    wr_en = 0; rd_en = 0;

    // Read remaining data
    rd_en = 1; #30;
    rd_en = 0;

    #20;
    $finish;
end

initial begin
    $monitor("Time=%0t clk=%b rst=%b wr_en=%b rd_en=%b buf_in=%h buf_out=%h fifo_counter=%d buf_empty=%b buf_full=%b",
        $time, clk, rst, wr_en, rd_en, buf_in, buf_out, fifo_counter, buf_empty, buf_full);
end

endmodule