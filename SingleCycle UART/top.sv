module top(
    input logic clk,reset,
    output logic tx_out
);
logic new_data;
logic [31:0] DATA_R,CONFIG_R,BAUD_DIV;
datapath PIPELINE(clk,reset,new_data,DATA_R,CONFIG_R,BAUD_DIV);

logic parity_sel,stop_sel,valid_out,parity_ok;
logic [7:0] data_out;
logic [11:0] baud_divisor;
uart_top UART(clk,reset,parity_sel,stop_sel,new_data,1'b1,DATA_R,baud_divisor,data_out,valid_out,parity_ok,tx_out);


always_comb begin
    parity_sel   = CONFIG_R[0];
    stop_sel     = CONFIG_R[1]; 
    baud_divisor = BAUD_DIV[11:0];
end
endmodule