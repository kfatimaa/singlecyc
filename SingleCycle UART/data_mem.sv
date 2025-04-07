module data_mem(
    input logic clk,reset,wr_en,rd_en,
    input logic [31:0] address,wdata,
    output logic [31:0] rdata,DATA_R,CONFIG_R,BAUD_DIV
    );

    logic [31:0] data_memory [0:2000];
    
    always_ff @ (negedge clk) begin
        if (wr_en)
            data_memory[address] <= wdata;
    end

    always_comb begin
        if (rd_en)
            rdata = data_memory[address];
        else 
            rdata = 32'b0;
        DATA_R    = data_memory[112];
        CONFIG_R  = data_memory[111];
        BAUD_DIV  = data_memory[110];
    end

endmodule