`timescale 1ns / 1ps

module single_port_sync_read_ROM_tb_v;
	localparam w=8;
	localparam d=16;
	// Inputs
	reg clk=0;
	reg [$clog2(d)-1:0] ad_rd;
	integer i=0;
	// Outputs
	wire [w-1:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	single_port_sync_read_ROM #(.w(w),.d(d)) uut (
		.clk(clk), 
		.ad_rd(ad_rd), 
		.data_out(data_out)
	);
	
	always begin
		clk=~clk;#0.5;
	end

	initial begin
		// Initialize Inputs
		$display("ROM TASK");
		for(i=0;i<16;i=i+1) begin
			read(i);
		end
	end
	
	task read (input [3:0]adr);
		begin
			@(posedge clk);
			ad_rd=adr;
			@(posedge clk);
			$display("ADDRESS=%0d,DATA=%b",ad_rd,data_out);
		end
	endtask
      
endmodule
