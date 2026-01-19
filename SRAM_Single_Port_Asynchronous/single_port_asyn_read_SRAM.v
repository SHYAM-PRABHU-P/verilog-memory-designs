`timescale 1ns / 1ps



module single_port_asyn_read_SRAM #(parameter w=8,parameter d=16)(
    input clk,[$clog2(d)-1:0]ad,[w-1:0]data_in,w_en,
    output [w-1:0]data_out
    );
 
    reg [w-1:0] ram [0:d-1];
       
    always @(posedge clk) begin
        if(w_en)
            ram[ad]<=data_in;  
    end
    
    assign data_out=ram[ad];
