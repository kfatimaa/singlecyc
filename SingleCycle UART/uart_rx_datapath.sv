module uart_rx_datapath(
    input logic clk,reset,
    input logic Rx_in,rx_sel,rx_sr_en,parity_sel,stop_sel,
    output logic valid_in,parity_ok,
    output logic [7:0] data_out
);

logic m_out;
mux2 M1(rx_sel,1'b1,Rx_in,m_out);

negedge_det NED(clk,reset,m_out,valid_in);

logic sr_out;
logic [11:0] sr_val;
shift_reg_12 SR_RX(clk,reset,1'b0,rx_sr_en,m_out,{12'b0},sr_out,sr_val);

logic parity_cal;
mux2_1b M2(parity_sel,^(sr_val[8:1]),~(^(sr_val[8:1])),parity_cal);

mux2_1b M3(stop_sel,sr_val[10],(sr_val[10]&sr_val[11]),valid_data);

always_comb begin
    data_out = sr_val[8:1];
    parity_ok = (parity_cal == sr_val[9]);

end


endmodule