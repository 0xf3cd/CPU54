module VGAController(
	input clk,
	input [31:0]code,
	output H_SYNC,
	output V_SYNC,
	output reg [11:0]RGB
);

	wire clk_25;
	reg [1:0]clk_div = 2'b0;
	always @(posedge clk) begin
		clk_div <= clk_div + 1'b1;
	end
	assign clk_25 = clk_div[1];

	wire valid;
	wire [9:0]actual_x;
	wire [9:0]actual_y;
	VGACounter VGACounter_(clk_25, H_SYNC, V_SYNC, valid, actual_x, actual_y);

	wire [5:0]area;
	wire [9:0]relative_x;
	wire [9:0]relative_y;
	VGARelativePosition VRP(
		.x(actual_x),
		.y(actual_y),
		.area(area),
		.relative_x(relative_x),
		.relative_y(relative_y)
	);

	wire [11:0]RGB_to_write;
	VGAGetRGB getRGB(
		.area(area),
		.encode(code),
		.x(relative_x),
		.y(relative_y),
		.RGB(RGB_to_write)
	);

	always @(negedge clk_25) begin
		if(valid) begin
			RGB <= RGB_to_write;
		end else begin
			RGB <= 12'b0;
		end
	end
endmodule