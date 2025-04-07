module tb_processor;

logic clk,reset;
logic new_data;
logic [31:0] DATA_R,CONFIG_R,BAUD_DIV;

// Instantiate the Processor
datapath dut (clk,reset,new_data,DATA_R,CONFIG_R,BAUD_DIV);

// Clock Generation
always begin
    #5 clk = ~clk; // 10ns clock period
end

// Testbench
initial begin
    // Initialize signals
    clk = 1;
    reset = 1;
    // Data Memory
   // Deassert reset
    #10 reset = 0;

end

endmodule