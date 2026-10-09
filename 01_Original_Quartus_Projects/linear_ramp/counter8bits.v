module counter_8bits(clk, out);
    input clk;
    output reg [7:0] out;
    
    always @(posedge clk) begin
             out <= out + 1;
        
    end
endmodule

