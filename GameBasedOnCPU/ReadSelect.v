module ReadSelect(
	input [31:0]addr,
	input [31:0]Switch,
	input [31:0]Random,
	input [31:0]DMEM,
	input [31:0]Timer,
	input [31:0]Button,
	input [31:0]RotaryEncoder,
	output reg[31:0]rdata
);

	always @(*) begin
		if(addr[11] == 1'b1) begin
			//外设
			case(addr[11:0])
				12'h808: rdata = Random;
				12'h80c: rdata = Switch;
				12'h810: rdata = Button;
				12'h814: rdata = Timer;
				12'h818: rdata = RotaryEncoder;
				default: rdata = DMEM;
			endcase
		end else begin
			//DMEM
			rdata = DMEM;
		end
	end
endmodule