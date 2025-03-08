module datapath(
    input clk,rst
);
logic[31:0] pc_out;
logic[31:0] instruction;
logic reg_wr, rd_en, wr_en, sel_A, sel_B;
logic [1:0] wb_sel;
logic [2:0] br_type;
logic [3:0] alu_op ;
logic [4:0] rs1,rs2,rsd;
logic[31:0] imm_val; 
logic [31:0] w_in,rdata1,rdata2;
logic br_taken;
logic [31:0] yA,yB;
logic [31:0] C;
logic [31:0] rdata,wdata;
logic [31:0] yC;

pgm_ctr pr_c1(yC,clk,rst,pc_out);
instr_mem inst_mem1(pc_out,instruction);
control_unit c1(instruction,reg_wr, rd_en, wr_en, sel_A, sel_B,wb_sel,br_type,alu_op );
imm_gen im_g1(instruction,imm_val);
register_file rf1(rs1,rs2,rsd,w_in,clk,rst,reg_wr,rdata1,rdata2);
branch_cond b1(br_type,rdata1,rdata2,br_taken);
mux_2 muxA(sel_A,pc_out,rdata1,yA);
mux_2 muxB(sel_B,rdata2,imm_val,yB);
ALU a1(alu_op,yA,yB,C);
data_mem dm1(C,rdata2,wr_en,rd_en,clk,rst,rdata);
mux_4 m4(wb_sel,pc_out+4,C,rdata,32'b0,wdata);
mux_2 muxC(br_taken,pc_out+4,C,yC);

always_comb begin
    w_in = wdata;
    rs1 = instruction[19:15];
    rs2 = instruction[24:20];
    rsd = instruction[11:7];
end

endmodule