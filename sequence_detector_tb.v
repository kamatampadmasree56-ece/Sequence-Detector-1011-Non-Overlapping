`timescale 1ns/1ps

module sequence_detector_tb;

reg clk;
reg reset;
reg x;

wire y;

// Instantiate DUT
sequence_detector uut(
    .clk(clk),
    .reset(reset),
    .x(x),
    .y(y)
);

// Clock Generation
always #5 clk = ~clk;

// Test Sequence
initial
begin
    $dumpfile("dump.vcd");
    $dumpvars(0, sequence_detector_tb);

    clk = 0;
    reset = 1;
    x = 0;

    #10;
    reset = 0;

    // Input Sequence : 1011
    #10 x = 1;
    #10 x = 0;
    #10 x = 1;
    #10 x = 1;

    // Extra Inputs
    #10 x = 0;
    #10 x = 1;
    #10 x = 0;
    #10 x = 1;
    #10 x = 1;

    #20;

    $finish;
end

// Display Values
initial
begin
    $monitor("Time=%0t Reset=%b Input=%b Output=%b",
              $time, reset, x, y);
end

endmodule
