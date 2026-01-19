`timescale 1ns / 1ps

module single_port_sync_read_ROM(clk,ad_rd, data_out);
    input clk;
	 input [3:0]ad_rd;
    output reg [7:0]data_out;
	 
	 reg [7:0]rom [0:15];
	 
	 initial begin
		$readmemb("rom.bin",rom,0,15);
	 end
	 
	 always @(posedge clk) begin
		data_out<=rom[ad_rd];
	 end
	 


endmodule
