module multiplier(
    input [11:0] input_signal,    // 12-bit input signal
    input [11:0] sine_wave,       // 12-bit sine wave
    output [7:0] output_signal    // 8-bit output signal
);

// Intermediate 24-bit product of the two 12-bit numbers
wire [23:0] product;
assign product = input_signal * sine_wave;

// Convert the 24-bit product to an 8-bit value
// This example simply truncates the least significant bits
assign output_signal = product[23:16];

endmodule
