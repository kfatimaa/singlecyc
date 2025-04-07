module baud_counter(
    input clk,reset,
    input logic[11:0] baud_divisor,
    output logic baud_comp
);
    logic [11:0] bc_in,bc_out;
    d_ff12 BC(clk,(reset || baud_comp),bc_in,bc_out);


    always_comb begin
        bc_in = bc_out + 1;
        baud_comp = ((baud_divisor-1) <= bc_out);
    end

endmodule