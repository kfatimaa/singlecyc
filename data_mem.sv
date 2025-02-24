module data_mem(
    input logic [31:0] address,wdata,
    input logic wr_en,rd_en,clk,rst,
    output logic [31:0] rdata

);
logic [31:0] data_memory [0:4095];
 always_ff @(negedge clk) begin
    if(wr_en)
    data_memory[address] <= wdata;
    end

always_comb begin
        if (rd_en)
            rdata = data_memory[address];
        else 
            rdata <= 32'b0;
    end

endmodule
