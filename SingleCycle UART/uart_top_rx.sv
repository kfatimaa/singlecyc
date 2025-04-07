module uart_top_rx(
        input logic clk,reset,
        input logic rx,parity_sel,stop_sel,rx_en,
        input logic [11:0] baud_divisor,
        output logic [7:0] data_out,
        output logic valid_out,parity_ok
    );

logic baud_comp;
baud_counter BC_RX(clk,reset,baud_divisor,baud_comp);

logic cnt_en_i,shift_done;
logic [3:0] cc_in,cc_out;
d_ff4  CC_RX(clk,(reset || shift_done),cnt_en_i,cc_in,cc_out);


logic valid_in_i,rx_sel,rx_shift_en,cnt_en,idle,ready;
uart_rx_controller CONTROLLER_RX(clk,reset,rx_en,baud_comp,valid_in_i,shift_done,rx_sel,rx_shift_en,cnt_en,valid_out,idle,ready);

logic valid_in;
uart_rx_datapath DATAPATH_RX(clk,reset,rx,rx_sel,rx_shift_en,parity_sel,stop_sel,valid_in,parity_ok,data_out);

always_comb begin
    cnt_en_i = cnt_en;
    valid_in_i = valid_in;
    cc_in = cc_out+1;
    shift_done = (cc_out == 4'd12);
end 
endmodule