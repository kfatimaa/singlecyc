module d_ff(
    input logic clk,reset,en,
    input logic q_in,
    output logic q_out
);

always_ff @(posedge clk) begin
    if(reset)
        q_out <= 1'b0;
    else begin
        if (en)
          q_out <= q_in;
    end
end


endmodule