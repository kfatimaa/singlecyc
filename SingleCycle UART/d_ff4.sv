module d_ff4(
    input logic clk,reset,en,
    input logic [3:0] q_in,
    output logic [3:0] q_out
);

always_ff @(posedge clk) begin
    if(reset)
        q_out <= 4'b0;
    else begin
        if (en)
          q_out <= q_in;
    end
end


endmodule