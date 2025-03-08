module imm_gen(
    input logic [31:0] instruction,
    output logic[31:0] imm_val
);
logic [6:0] opcode;
always_comb begin
    opcode = instruction[6:0];
    case(opcode)
   
    7'b0100011: imm_val = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; //S-TYPE
    7'b0110011: imm_val = 32'b0; //R-TYPE
    7'b1101111 : imm_val = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; //J-TYPE
    7'b1100011 : imm_val = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; //B-TYPE
    7'b0110111 : imm_val = {instruction[31:12], 12'b0}; // LUI
    7'b0010111 : imm_val = {instruction[31:12], 12'b0}; // AUIPC
    7'b0000011 : imm_val = {{20{instruction[31]}},instruction[31:20]}; //I-TYPE(LOAD)
    7'b0010011 : imm_val = {{20{instruction[31]}},instruction[31:20]}; //I-TYPE


    endcase
end

endmodule 