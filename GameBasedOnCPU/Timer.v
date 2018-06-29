module Timer(
	input clk_cpu,
	input clk_1Hz,
	input [31:0]wdata,
	input we,
	output [31:0]value
);
	reg [31:0]time_counter = 32'b0;
	wire clk = (we)? clk_cpu: clk_1Hz;

	always @(negedge clk) begin
		if(we) begin
			time_counter <= wdata;
		end else begin
			if(time_counter == 32'b0) begin
				time_counter <= time_counter;
			end else begin
				time_counter <= time_counter - 1'b1;
			end
		end
	end

	assign value = time_counter;
endmodule