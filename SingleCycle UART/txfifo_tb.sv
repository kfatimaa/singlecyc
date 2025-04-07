module txfifo_tb();

logic clk,reset;
logic en,shift,new_data,txff,txfe;
logic [7:0] data_in,data_out;
logic [7:0] sr0,sr1,sr2,sr3,sr4,sr5,sr6,sr7;

tx_fifo dut(clk,reset,en,shift,new_data,data_in,txff,txfe,data_out,sr0,sr1,sr2,sr3,sr4,sr5,sr6,sr7);

always
    #5 clk = ~clk;

initial begin
    clk = 0;
    en  = 0;
    shift = 0;
    new_data = 0;
    data_in = 8'b0;
    en = 0;
    #5reset = 1;
    #5 reset = 0;
    #5 new_data = 1;
    data_in = 8'h24;
    #10 data_in = 8'h32;
    #10 data_in = 8'h63;    
    #10 data_in = 8'h15;    
    #10 data_in = 8'ha5; 
    #10 data_in = 8'hd1;
    shift = 1;    
    #10 data_in = 8'h05;    
    #10 data_in = 8'hb2;  
    #10 new_data = 0;   

end


endmodule