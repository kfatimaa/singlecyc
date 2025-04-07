module datapath(
    input logic clk,reset,
    output logic new_data,
    output logic [31:0] DATA_R,CONFIG_R,BAUD_DIV
);
    
logic [31:0] br_a,br_b,br_y;
logic br_sel;
mux2 M_BR(br_sel,br_a,br_b,br_y);

logic [31:0] pc;
program_counter PC0(clk,reset,br_y,pc);

logic [31:0] instruction;
inst_mem IM0(pc,instruction);

logic mim_sel;
logic [31:0] instruction0;
mux2 M_IM(mim_sel,instruction,32'h00000013,instruction0);

logic[6:0] opcode;
logic[31:0] pc1,instruction1;
d_ff32 D_PC1(clk,reset,pc,pc1);
d_ff32 D_IR1(clk,reset,instruction0,instruction1);

logic reg_wr,rd_en,wr_en,sel_A,sel_B,sel_pA,sel_pB;
logic [1:0] wb_sel;
logic [2:0] br_type;
logic [3:0] alu_op;
logic [31:0] instruction2;
control_unit C0(instruction1,instruction2,reg_wr,rd_en,wr_en,sel_A,sel_B,sel_pA,sel_pB,wb_sel,br_type,alu_op);

logic [31:0] imm_val;
imm_gen IG0(instruction1,imm_val);

logic reg_wr1;
logic [31:0] rdata1,rdata2,rf_in;
logic [4:0] rs1,rs2,rsd;
reg_file RF0(clk,reset,reg_wr1,rs1,rs2,rsd,rf_in,rdata1,rdata2);

logic [31:0] m_in2,pa_out,pb_out;
mux2 P_A(sel_pA,rdata1,m_in2,pa_out);
mux2 P_B(sel_pB,rdata2,m_in2,pb_out);

logic [31:0] ma_y;
mux2 M_A(sel_A,pc1,pa_out,ma_y);

logic [31:0] mb_y;
mux2 M_B(sel_B,pb_out,imm_val,mb_y);

logic [31:0] alu_out;
alu ALU0(alu_op,ma_y,mb_y,alu_out);

logic br_taken;
br_cond B0(br_type,pa_out,pb_out,br_taken);

logic [31:0] pc2,alu_out1,pb_out1;

d_ff32 D_PC2(clk,reset,pc1,pc2);
d_ff32 D_ALU(clk,reset,alu_out,alu_out1);
d_ff32 D_WD (clk,reset,pb_out,pb_out1);
d_ff32 D_IR2(clk,reset,instruction1,instruction2);

logic wr_en1,rd_en1;
logic [1:0] wb_sel1;
d_ffcont D_CN1(clk,reset,reg_wr,wr_en,rd_en,wb_sel,reg_wr1,wr_en1,rd_en1,wb_sel1);

logic [31:0] data_out;
data_mem D0(clk,reset,wr_en1,rd_en1,alu_out1,pb_out1,data_out,DATA_R,CONFIG_R,BAUD_DIV);

logic [31:0] wdata;
mux4 M_WB(wb_sel1,pc2+4,alu_out1,data_out,data_out,wdata);

always_comb begin
    br_a = pc + 4;
    rf_in = wdata;
    br_sel = br_taken;
    mim_sel = br_taken;
    br_b = alu_out;
    m_in2 = wdata;
    rs1 = instruction1[19:15];
    rs2 = instruction1[24:20];
    rsd = instruction2[11:7];
    new_data = (instruction2[6:0] == 7'b0100011) & (alu_out1 == 32'h70);
    opcode = instruction1[6:0];
end

endmodule