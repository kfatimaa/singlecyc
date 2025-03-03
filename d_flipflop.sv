module d_flipflop(output logic [31:0] q ,
input logic clk, reset, [31:0] d
);
always_ff @ (posedge clk or posedge reset)
begin
    if (reset)
        q<=  32'b0;

        else 
            q <= d;
    end


endmodule
