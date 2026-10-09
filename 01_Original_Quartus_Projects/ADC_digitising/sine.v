module sine_wave_generator(
    input clk,  // 56 kHz clock
    output reg [11:0] sine_value  // Output sine wave value, 12-bit
);

// Constants
parameter TABLE_SIZE = 8;  // Minimal size of the sine table
reg [11:0] sine_table[TABLE_SIZE-1:0];  // Sine table for 12-bit output

// Phase accumulator
reg [2:0] phase_acc = 0;  // 3-bit phase accumulator for indexing

// Initialize the sine table with precomputed values
initial begin
    sine_table[0] = 2048;  // Mid-point
    sine_table[1] = 2048 + 2047 * 0.70711;
    sine_table[2] = 2048 + 2047 * 1;
    sine_table[3] = 2048 + 2047 * 0.70711;
    sine_table[4] = 2048 + 2047 * 0;
    sine_table[5] = 2048 + 2047 * -0.70711;
    sine_table[6] = 2048 + 2047 * -1;
    sine_table[7] = 2048 + 2047 * -0.70711;
end

// Generate the sine wave
always @(posedge clk) begin
    sine_value <= sine_table[phase_acc];
    phase_acc <= phase_acc + 1;
end

endmodule
