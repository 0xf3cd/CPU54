module VGARelativePosition(
	input [9:0]x,
	input [9:0]y,
	output [5:0]area,
	output reg [9:0]relative_x,
	output reg [9:0]relative_y
);
	
	reg [5:0]temp_area;
	always @(*) begin
		if(y >= 10'd52 && y <= 10'd251) begin
			if(x >= 10'd143 && x <= 10'd342) begin
				temp_area = 6'b000001;
			end else if(x >= 10'd363 && x <= 10'd562) begin
				temp_area = 6'b000010;
			end else if(x >= 10'd583 && x <= 10'd782) begin
				temp_area = 6'b000100;
			end else begin
				temp_area = 6'b000000;
			end
		end else if(y >= 10'd292 && y <= 10'd491) begin
			if(x >= 10'd143 && x <= 10'd342) begin
				temp_area = 6'b001000;
			end else if(x >= 10'd363 && x <= 10'd562) begin
				temp_area = 6'b010000;
			end else if(x >= 10'd583 && x <= 10'd782) begin
				temp_area = 6'b100000;
			end else begin
				temp_area = 6'b000000;
			end
		end else begin
			temp_area = 6'b000000;
		end
	end

	always @(*) begin
		case(temp_area)
			6'b000001: begin
				relative_x = x - 10'd142;
				relative_y = y - 10'd51;
			end
			6'b000010: begin
				relative_x = x - 10'd362;
				relative_y = y - 10'd51;
			end
			6'b000100: begin
				relative_x = x - 10'd582;
				relative_y = y - 10'd51;
			end
			6'b001000: begin
				relative_x = x - 10'd142;
				relative_y = y - 10'd291;
			end
			6'b010000: begin
				relative_x = x - 10'd362;
				relative_y = y - 10'd291;
			end
			6'b100000: begin
				relative_x = x - 10'd582;
				relative_y = y - 10'd291;
			end
			default: begin
				relative_x = 10'bxxxxxxxxxx;
				relative_y = 10'bxxxxxxxxxx;
			end
		endcase
	end

	assign area = temp_area;
endmodule