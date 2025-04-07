module uart_tx_datapath(
    input logic clk,reset,
    input logic load,tx_sr_en,parity_sel,tx_sel,
    input logic [7:0] i,
    output logic Tx_out
);

logic parity_bit;
mux2 M1(parity_sel,(^i),~(^i),parity_bit);

logic sr_out;
logic [11:0] sr_val;
shift_reg_12 SR_TX(clk,reset,load,tx_sr_en,1'b0,{1'b1,1'b1,parity_bit,i[7],i[6],i[5],i[4],i[3],i[2],i[1],i[0],1'b0},sr_out,sr_val);

mux2 M2(tx_sel,1'b1,sr_out,Tx_out);


endmodule