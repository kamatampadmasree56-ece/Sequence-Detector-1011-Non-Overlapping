`timescale 1ns/1ps

module sequence_detector(
    input clk,
    input reset,
    input x,
    output reg y
);

// State Encoding
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

// State Registers
reg [2:0] current_state;
reg [2:0] next_state;

// State Register
always @(posedge clk or posedge reset)
begin
    if(reset)
        current_state <= S0;
    else
        current_state <= next_state;
end

// Next State Logic
always @(*)
begin
    case(current_state)

        S0:
            if(x)
                next_state = S1;
            else
                next_state = S0;

        S1:
            if(x)
                next_state = S1;
            else
                next_state = S2;

        S2:
            if(x)
                next_state = S3;
            else
                next_state = S0;

        S3:
            if(x)
                next_state = S4;
            else
                next_state = S2;

        S4:
            next_state = S0;

        default:
            next_state = S0;

    endcase
end

// Output Logic
always @(*)
begin
    if(current_state == S4)
        y = 1'b1;
    else
        y = 1'b0;
end

endmodule
