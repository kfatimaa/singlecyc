module test;
logic clk,reset,tx_out;

top SC_UART(clk,reset,tx_out);

always
    #5 clk = ~clk;

initial begin
reset = 1;
clk   = 1;
#5 reset =0;
end



endmodule