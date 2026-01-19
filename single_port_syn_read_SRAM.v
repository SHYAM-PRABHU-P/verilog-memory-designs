`timescale 1ns / 1ps

module single_port_syn_read_SRAM #(parameter w=8,parameter d=16)(
    input clk,w_en,
    input [w-1:0]data_in,
    input [$clog2(d)-1:0]ad,
    output reg [w-1:0]data_out
    );
    
    reg [w-1:0] ram [0:d-1];
    reg [$clog2(d)-1:0]addr;
    
    always @(posedge clk) begin
        if(w_en) begin
            ram[ad] <=  data_in;
            addr<=ad;
        end
        data_out<=ram[addr];
    end
endmodule
