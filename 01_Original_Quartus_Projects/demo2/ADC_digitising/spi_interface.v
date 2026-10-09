module spi_interface(clk, sclk, din, dout, cs, count, dataout, sampling_pulses);

input clk;
input dout;
output reg din;
output wire sclk;
output reg cs;
output reg sampling_pulses;
output reg [11:0] dataout;
reg [11:0] data_temp;
reg clock_out;
output reg [3:0] count;

initial
begin
count = 4'd0;
cs = 1;
din = 0;
clock_out = 0;
dataout = 12'd0;
data_temp = 12'd0;
// sampling_pulses = 0;
end



always@(negedge clk) begin

if (count == 15)
begin
cs <= 0;
end

end


assign sclk = cs?1:clk;



always@(posedge clk) begin
count <= count +4'd1;
end



always@(posedge clk) begin
case (count)
0:		dataout <= data_temp;
3:		data_temp[11] <= dout;
4:		data_temp[10] <= dout;
5:		data_temp[9] <= dout;
6:		data_temp[8] <= dout;
7:		begin data_temp[7] <= dout; sampling_pulses <= 1; end
8:		data_temp[6] <= dout;
9:		data_temp[5] <= dout;
10:	data_temp[4] <= dout;
11:	data_temp[3] <= dout;
12:	data_temp[2] <= dout;
13:	data_temp[1] <= dout;
14:	data_temp[0] <= dout;
15:	sampling_pulses <= 0;
endcase
end



endmodule
