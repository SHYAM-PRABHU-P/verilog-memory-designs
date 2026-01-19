`timescale 1ns / 1ps

module single_port_sync_read_ROM #(parameter w=8,parameter d=16)(clk,ad_rd, data_out);
    input clk;
	input [$clog2(d)-1:0]ad_rd;
	output reg [w-1:0]data_out;
	 
	reg [w-1:0]rom [0:d-1];
	reg [w-1:0] d_out;
	 initial begin
		 $readmemb("rom.bin",rom,0,d-1);
	 end
	 
	 always @(posedge clk) begin
		d_out<=rom[ad_rd];
		data_out<=d_out;
	 end
	 


endmodule
