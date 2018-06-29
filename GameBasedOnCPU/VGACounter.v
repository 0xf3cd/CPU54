module VGACounter(clk, H_SYNC, V_SYNC, VALID, X, Y);
	input clk;
	output H_SYNC;
	output V_SYNC;
	output VALID;//在非消隐区时为1（即此时可以显示图像）
	output [9:0]X;
	output [9:0]Y;//当前扫描位置的坐标

	/*
	该模块负责进行行、场扫描的计数，并控制其同步信号
	同时传递给上级模块当前扫描点的坐标
	并告知外部当前是否处于消隐区（是否可以发送电子产生图像）
	*/

	reg [9:0]H_counter = 0;
	reg [9:0]V_counter = 0;

	always @(posedge clk) begin
		if(H_counter == 10'd799) begin
			H_counter <= 0;
		end else begin
			H_counter <= H_counter + 1;
		end
	end

	always @(posedge clk) begin
		if(H_counter == 10'd799) begin
			if(V_counter == 10'd524) begin
				V_counter <= 0;
			end else begin
				V_counter <= V_counter + 1;
			end
		end else begin
			V_counter <= V_counter;
		end
	end

	assign H_SYNC = (H_counter >= 10'd96);
	assign V_SYNC = (V_counter >= 10'd2);

	//assign VALID=(H_counter>=10'd143)&&(H_counter<=10'd782)
	//				&&(V_counter>=10'd32)&&(V_counter<=10'd511);
	assign VALID = (H_counter >= 10'd142) && (H_counter <= 10'd781)
				&& (V_counter >= 10'd32) && (V_counter <= 10'd511);
	//由于RGB信息在时钟下降沿时写入相关端口（避免竞争冒险），所以VALID需提前一个时钟周期

	assign X = H_counter;
	assign Y = V_counter;
endmodule