module Switch(
	input clk,
	input [14:0]sw,
	output reg[31:0]switch
);
	always @(posedge clk) begin
		switch <= {17'b0, sw};
	end
endmodule