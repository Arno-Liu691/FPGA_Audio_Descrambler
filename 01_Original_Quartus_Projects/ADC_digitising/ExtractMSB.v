module ExtractMSB(
    input [23:0] input_signal,
    output reg [7:0] output_bits
);

    always @* begin
        output_bits = input_signal[23:16];
    end

endmodule
