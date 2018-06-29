module RotaryEncoder(
	input clk,
	input RotaryButton,
	output [31:0]RotaryEncoder_out
);
	reg [31:0]RE = 32'b0;
	always @(posedge clk) begin
		RE <= {31'b0, RotaryButton};
	end
	assign RotaryEncoder_out = RE;
endmodule