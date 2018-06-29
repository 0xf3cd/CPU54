module Button(
	input clk,
	input [4:0]bt,
	output reg[31:0]button
);
	always @(posedge clk) begin
		button <= {27'b0, bt};
	end
endmodule