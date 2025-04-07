module reg_file(
    input logic clk,reset,reg_wr,
    input logic [4:0] raddr1,raddr2,waddr,
    input logic [31:0] wdata,
    output logic [31:0] rdata1,rdata2
    ); 
    logic [31:0] registers [0:31];

    always_ff @ (negedge clk or posedge reset) begin
        if (reset) begin
            registers[0] <= 32'd0;
            registers[1] <= 32'd0;
            registers[2] <= 32'h200;
            registers[3] <= 32'd0;
            registers[4] <= 32'd0;
            registers[5] <= 32'd0;
            registers[6] <= 32'd0;
            registers[7] <= 32'd0;
            registers[8] <= 32'd0;
            registers[9] <= 32'd0;
            registers[10] <= 32'd0;
            registers[11] <= 32'd0;
            registers[12] <= 32'd0;
            registers[13] <= 32'd0;
            registers[14] <= 32'd0;
            registers[15] <= 32'd0;
            registers[16] <= 32'd0;
            registers[17] <= 32'd0;
            registers[18] <= 32'd0;
            registers[19] <= 32'd0;
            registers[20] <= 32'd0;
            registers[21] <= 32'd0;
            registers[22] <= 32'd0;
            registers[23] <= 32'd0;
            registers[24] <= 32'd0;
            registers[25] <= 32'd0;
            registers[26] <= 32'd0;
            registers[27] <= 32'd0;
            registers[28] <= 32'd0;
            registers[29] <= 32'd0;
            registers[30] <= 32'd0;
            registers[31] <= 32'd0;
        end
        else begin
            if(reg_wr)  
                registers[waddr] <= wdata;
            registers[0] <= 32'b0;
        end
    end

    always_comb begin
            rdata1 = registers[raddr1];
            rdata2 = registers[raddr2];
        end

    endmodule