`define BACKGROUND 12'b1110_1110_1110
`define CYAN_RGB 12'b1100_0000_0000
`define VIOLET_RGB 12'b1111_1110_0000
`define DARK_BROWN_RGB 12'b0011_0101_1100
`define YELLOW_RGB 12'b0001_0110_0110

module VGAGetRGB(
	input [5:0]area,
	input [31:0]encode,
	input [9:0]x,
	input [9:0]y, //x和y为相对位置
	output reg [11:0]RGB
);

	reg [1:0]current_color;
	reg [2:0]current_shape;
	always @(*) begin
		case(area)
			6'b000001: begin
				current_shape = encode[2:0];
				current_color = encode[21:20];
			end
			6'b000010: begin
				current_shape = encode[5:3];
				current_color = encode[23:22];
			end
			6'b000100: begin
				current_shape = encode[8:6];
				current_color = encode[25:24];
			end
			6'b001000: begin
				current_shape = encode[11:9];
				current_color = encode[27:26];
			end
			6'b010000: begin
				current_shape = encode[14:12];
				current_color = encode[29:28];
			end
			6'b100000: begin
				current_shape = encode[17:15];
				current_color = encode[31:30];
			end
			default: begin
				current_shape = 3'bx;
				current_color = 2'bx;
			end
		endcase
	end

	reg [11:0]current_RGB;
	always @(*) begin
		case(current_color)
			2'b00: current_RGB = `CYAN_RGB;
			2'b01: current_RGB = `VIOLET_RGB;
			2'b10: current_RGB = `YELLOW_RGB;
			2'b11: current_RGB = `DARK_BROWN_RGB;
		endcase
	end

	always @(*) begin
		case(current_shape)
			3'b000: begin
				RGB = `BACKGROUND;
			end
			3'b001: begin
				if(y >= 21 && y <= 40) begin
					RGB = (x >= 91 && x <= 110)? current_RGB: `BACKGROUND;
				end else if(y >= 41 && y <= 60) begin
					RGB = (x >= 81 && x <= 120)? current_RGB: `BACKGROUND;
				end else if(y >= 61 && y <= 80) begin
					RGB = (x >= 71 && x <= 130)? current_RGB: `BACKGROUND;
				end else if(y >= 81 && y <= 100) begin
					RGB = (x >= 61 && x <= 140)? current_RGB: `BACKGROUND;
				end else if(y >= 101 && y <= 180) begin
					RGB = (x >= 91 && x <= 110)? current_RGB: `BACKGROUND;
				end else begin
					RGB = `BACKGROUND;
				end
			end
			3'b010: begin
				if(y >= 161 && y <= 180) begin
					RGB = (x >= 91 && x <= 110)? current_RGB: `BACKGROUND;
				end else if(y >= 141 && y <= 160) begin
					RGB = (x >= 81 && x <= 120)? current_RGB: `BACKGROUND;
				end else if(y >= 121 && y <= 140) begin
					RGB = (x >= 71 && x <= 130)? current_RGB: `BACKGROUND;
				end else if(y >= 101 && y <= 120) begin
					RGB = (x >= 61 && x <= 140)? current_RGB: `BACKGROUND;
				end else if(y >= 21 && y <= 100) begin
					RGB = (x >= 91 && x <= 110)? current_RGB: `BACKGROUND;
				end else begin
					RGB = `BACKGROUND;
				end
			end
			3'b011: begin
				if(x >= 21 && x <= 40) begin
					RGB = (y >= 91 && y <= 110)? current_RGB: `BACKGROUND;
				end else if(x >= 41 && x <= 60) begin
					RGB = (y >= 81 && y <= 120)? current_RGB: `BACKGROUND;
				end else if(x >= 61 && x <= 80) begin
					RGB = (y >= 71 && y <= 130)? current_RGB: `BACKGROUND;
				end else if(x >= 81 && x <= 100) begin
					RGB = (y >= 61 && y <= 140)? current_RGB: `BACKGROUND;
				end else if(x >= 101 && x <= 180) begin
					RGB = (y >= 91 && y <= 110)? current_RGB: `BACKGROUND;
				end else begin
					RGB = `BACKGROUND;
				end
			end
			3'b100: begin
				if(x >= 161 && x <= 180) begin
					RGB = (y >= 91 && y <= 110)? current_RGB: `BACKGROUND;
				end else if(x >= 141 && x <= 160) begin
					RGB = (y >= 81 && y <= 120)? current_RGB: `BACKGROUND;
				end else if(x >= 121 && x <= 140) begin
					RGB = (y >= 71 && y <= 130)? current_RGB: `BACKGROUND;
				end else if(x >= 101 && x <= 120) begin
					RGB = (y >= 61 && y <= 140)? current_RGB: `BACKGROUND;
				end else if(x >= 21 && x <= 100) begin
					RGB = (y >= 91 && y <= 110)? current_RGB: `BACKGROUND;
				end else begin
					RGB = `BACKGROUND;
				end
			end
			3'b101: begin
				if(x >= 81 && x <= 120 && y >= 81 && y <= 120) begin
					RGB = current_RGB;
				end else begin
					RGB = `BACKGROUND;
				end
			end
			default: begin
				RGB = `BACKGROUND;
			end
		endcase
	end
endmodule