`timescale 1ns / 1ps


module dual_port_asyn_read_SRAM_tb();
reg clk=1;
	reg [3:0] ad_rd;
	reg [3:0] ad_wr;
	reg [7:0] wr_d;
	reg w_en;
	reg [1:0]delay;
	 integer i=0,succ_count=0,err_count=0,totl_count=0;
	 reg [7:0] wr_data;
	 reg [3:0] rd_data;
	// Outputs
	wire [7:0] rd_d;

	// Instantiate the Unit Under Test (UUT)
	dual_port_asyn_read_SRAM uut (
		.clk(clk), 
		.ad_rd(ad_rd), 
		.ad_wr(ad_wr), 
		.wr_d(wr_d), 
		.w_en(w_en), 
		.rd_d(rd_d)
	);

	always begin
        clk=~clk;#0.5;
    end
    
    task write (input [3:0]adr,input [7:0] data);
        begin
            @(posedge clk);
            w_en=1;
            ad_wr=adr;
            wr_d=data;
				
        end
    endtask
    
    task read (input [3:0]adr);
        begin
            @(posedge clk);
				w_en=0;
            ad_rd=adr;
            
        end
    endtask
    
    task compare (input [3:0]adr,input [7:0] exp_data,input [7:0] obs_data);
        begin
            if(exp_data==obs_data) begin
                $display("SUCCESS ----- ADDRESS=%0d,EXPECTED DATA=%b,OBSERVED DATA=%b",adr,exp_data,obs_data);
                succ_count=succ_count+1;
            end
            else begin
                $display("ERROR ----- ADDRESS=%0d,EXPECTED DATA=%b,OBSERVED DATA=%b",adr,exp_data,obs_data);
                err_count=err_count+1;
            end
            totl_count=totl_count+1;
        end
    endtask
    
    initial begin
	  $display("TASK 1");
     for(i=0;i<10;i=i+1) begin
                wr_data=$random;
                write(i,wr_data);
                read(i);
                #0.1;
                compare(i,wr_data,rd_d);
                delay=$random;
                #(delay);
            end
            
            read(2);#1;
            read(6);#1;
            $display("SUCCESS COUNT=%0d,ERROR COUNT=%0d,TOTAL COUNT=%0d",succ_count,err_count,totl_count);
    
	 
	 $display("TASK 2");
     for(i=0;i<10;i=i+1) begin
					 rd_data=$random;
                wr_data=$random;
                write(rd_data,wr_data);
                read(rd_data);
                #0.1;
                compare(rd_data,wr_data,rd_d);
                delay=$random;
                #(delay);
            end
            
            read(2);#1;
            read(6);#1;
            $display("SUCCESS COUNT=%0d,ERROR COUNT=%0d,TOTAL COUNT=%0d",succ_count,err_count,totl_count);
    end
	 
	 
	
      
endmodule
