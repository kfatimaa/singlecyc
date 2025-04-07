module uart_top(
    input logic clk,reset,
    input logic parity_sel,stop_sel,new_data,rx_en,
    input logic [31:0] data_reg,
    input logic [11:0] baud_divisor,
    output logic [7:0] data_out,
    output logic valid_out,parity_ok,tx_out
);

uart_top_tx UART_TX(clk,reset,parity_sel,stop_sel,new_data,data_reg,baud_divisor,tx_out);

logic rx_in;
uart_top_rx UART_RX(clk,reset,rx_in,parity_sel,stop_sel,rx_en,baud_divisor,data_out,valid_out,parity_ok);

assign rx_in = tx_out;

endmodule