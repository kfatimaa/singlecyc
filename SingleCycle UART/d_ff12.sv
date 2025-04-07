module d_ff12(
    input logic clk,reset,
    input logic [11:0] q_in,
    output logic [11:0] q_out
);

always_ff @(posedge clk) begin
    if(reset)
        q_out <= 12'b0;
    else 
        q_out <= q_in;
end


endmodule