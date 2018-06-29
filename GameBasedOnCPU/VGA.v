module VGA(
	input clk,
	input [31:0]wdata,
	input we,
	output H_SYNC,
	output V_SYNC,
	output [11:0]RGB
);

	reg [31:0]code = 32'b0;
	always @(negedge clk) begin
		if(we) begin
			code <= wdata;
		end else begin
			code <= code;
		end
	end

	VGAController VGAC(clk, code, H_SYNC, V_SYNC, RGB);
endmodule