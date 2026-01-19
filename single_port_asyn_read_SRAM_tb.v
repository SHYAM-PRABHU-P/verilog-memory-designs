`timescale 1ns / 1ps


module single_port_asyn_read_SRAM_tb();
    localparam w=8;
    localparam d=16;
    
    reg clk=1;
    reg [$clog2(d)-1:0]ad;
    reg [w-1:0]data_in;
    reg w_en=0;
    wire [w-1:0] data_out;
    reg [w-1:0] w_data;
    reg [1:0]delay;
    integer i=0,succ_count=0,err_count=0,totl_count=0;
    
    
    
    single_port_asyn_read_SRAM #(.w(w),.d(d)) uut(.clk(clk),.ad(ad),.data_in(data_in),.w_en(w_en),.data_out(data_out));
    
    always begin
        clk=~clk;#0.5;
    end
    
    task write (input [3:0]adr,input [7:0]data); 
        begin
            @(posedge clk);
            w_en=1'b1;
            ad=adr;
            data_in=data;
        end
    endtask
    
    task read (input [3:0]adr);
        begin
            @(posedge clk);
            w_en=1'b0;
            ad=adr;
        end
    endtask
    
    task compare (input[3:0]adr,input [7:0]exp_data,input [7:0] obs_data);
        begin
            if(exp_data==obs_data) begin
                $display("SUCCESS-----ADDRESS=%0d,EXPECTED DATA=%b,OBSERVED DATA=%b",adr,exp_data,obs_data);
                succ_count=succ_count+1;
                end
            else begin
                $display("ERROR-----ADDRESS=%0d,EXPECTED DATA=%b,OBSERVED DATA=%b",adr,exp_data,obs_data);
                err_count=err_count+1;
                end
            totl_count=totl_count+1;
        end
    endtask
    
    initial begin 
        for(i=0;i<10;i=i+1) begin
            w_data=$random;
            write(i,w_data);
            read(i);
            #0.1;
            compare(i,w_data,data_out);
            delay=$random;
            #(delay);
        end 
        
        read(3);#1;
        read(5);#1;
       $display("SUCCESS COUNT=%0d,ERROR COUNT=%0d,TOTAL COUNT=%0d",succ_count,err_count,totl_count);
     end
endmodule
