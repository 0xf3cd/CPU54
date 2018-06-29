module WriteSelect(
	input [31:0]addr,
	input we,
	output reg DMEM_we,
	output reg Seg_we,
	output reg VGA_we,
	output reg Timer_we
);

	always @(*) begin
		if(addr[11] == 1'b1) begin
			//外设
			case(addr[11:0])
				12'h800: begin
					VGA_we = we;
					Seg_we = 1'b0;
					DMEM_we = 1'b0;
					Timer_we = 1'b0;
				end
				12'h804: begin
					VGA_we = 1'b0;
					Seg_we = we;
					DMEM_we = 1'b0;
					Timer_we = 1'b0;
				end
				12'h814: begin
					VGA_we = 1'b0;
					Seg_we = 1'b0;
					DMEM_we = 1'b0;
					Timer_we = we;
				end
				default: begin
					VGA_we = 1'b0;
					Seg_we = 1'b0;
					DMEM_we = 1'b0;
					Timer_we = 1'b0;
				end
			endcase
		end else begin
			//普通DMEM
			VGA_we = 1'b0;
			Seg_we = 1'b0;
			DMEM_we = we;
			Timer_we = 1'b0;
		end
	end
endmodule