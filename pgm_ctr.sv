module pgm_ctr(
    input logic [31:0] pc_in,
    input logic clk,rst, 
    output logic [31:0] pc_out
    );

    always_ff @(posedge clk or posedge rst) begin
        if (rst) 
            pc_out <= 32'b0;
        else 
            pc_out <= pc_in;
    end


endmodule
