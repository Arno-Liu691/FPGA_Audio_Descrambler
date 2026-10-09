module twos_complement_converter(
    input [11:0] unsigned_binary, // 12-bit unsigned input
    output reg [11:0] twos_complement // 12-bit 2's complement output
);

always @(unsigned_binary) begin
    // Inverting all bits and adding 1
    twos_complement = ~unsigned_binary + 1;
end

endmodule