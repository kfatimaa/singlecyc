module tx_fifo(
    input logic clk,reset,
    input logic en,shift,new_data,
    input logic [7:0] data_in,
    output logic txff,txfe,
    output logic [7:0] data_out,
    output logic [7:0] sr0,sr1,sr2,sr3,sr4,sr5,sr6,sr7
);
localparam logic [7:0] ZERO_ARRAY [0:7] = '{default: 8'b0};
logic [3:0]counter;
logic [7:0]FIFO[0:7];

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        FIFO <= ZERO_ARRAY;
        counter <= 4'h0;
    end
    else begin
        if(!txff & new_data & en) begin
            FIFO[counter] = data_in;
            counter = counter + 1;
        end
        if(shift & en) begin
            FIFO[0] <= FIFO[1];
            FIFO[1] <= FIFO[2];
            FIFO[2] <= FIFO[3];
            FIFO[3] <= FIFO[4];
            FIFO[4] <= FIFO[5];
            FIFO[5] <= FIFO[6];
            FIFO[6] <= FIFO[7];
            FIFO[7] <= 8'b0;
            counter = counter - 1;
        end
    end
end

always_comb begin
    if(counter == 0)
        txfe = 1;
    else   
        txfe = 0;

    if(counter == 8)
        txff = 1;
    else   
        txff = 0;
    data_out = FIFO[0];
    
end
endmodule