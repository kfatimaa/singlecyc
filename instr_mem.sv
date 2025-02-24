module instr_mem(
    input logic [31:0] address,
    output logic [31:0] instruction    
);
logic [31:0] instruction_memory [0:4095];

initial begin
	$readmemh("D:/CA/Lab/Test/src/main.txt", instruction_memory);
	end
assign instruction = instruction_memory[address[13:2]];

endmodule