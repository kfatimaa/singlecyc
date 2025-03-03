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
logic[31:0] pcA_op;
logic[31:0] IRA_op;
logic[31:0] IRB_op;
logic[31:0] alu_ffop1;
logic[31:0]wd_ffop;
logic[31:0]pcB_op;
logic reg_wrff, rd_enff, wr_enff;
logic [1:0] wb_selff;
logic sel_C1,sel_C2;
logic [31:0] ophaz1,ophaz2;
logic sels_a;
logic [31:0] IRA_in;




pgm_ctr pr_c1(yC,clk,rst,pc_out);
d_flipflop prg_ctrA(pc_out,clk,rst,pcA_op);
instr_mem inst_mem1(pc_out,instruction);
d_flipflop IR_A(IRA_in,clk,rst,IRA_op);

d_flipflop IR_B(IRA_op,clk,rst,IRB_op);



control_unit c1(IRA_op,reg_wr, rd_en, wr_en, sel_A, sel_B, sel_C1,sel_C2,wb_sel,br_type,alu_op );
dff_ctrl dff_ct(reg_wr, rd_en, wr_en,wb_sel,reg_wrff,rd_enff,wr_enff,wb_selff);
mux_4 m4(wb_sel,pcB_op+4,alu_ffop1,rdata,32'b0,wdata);

imm_gen im_g1(IRA_op,imm_val);
register_file rf1(rs1,rs2,rsd,w_in,clk,rst,reg_wrff,rdata1,rdata2);
branch_cond b1(br_type,ophaz1,ophaz2,br_taken);

d_flipflop wd_ff(ophaz2,clk,rst,wd_ffop);
mux_2 muxA(sel_A,pcA_op,ophaz1,yA);
d_flipflop prg_ctrB(pcA_op,clk,rst,pcB_op);
mux_2 muxB(sel_B,ophaz2,imm_val,yB);
ALU a1(alu_op,yA,yB,C);
d_flipflop alu_ff(C,clk,rst,alu_ffop1);
data_mem dm1(alu_ffop1,wd_ffop,wr_enff,rd_enff,clk,rst,rdata);
mux_4 m4(wb_selff,pcB_op+4,alu_ffop1,rdata,32'b0,wdata);
mux_2 muxC(br_taken,pc_out+4,alu_ffop1,yC);
mux_2 hazard1(sel_C1,rdata1,wdata,ophaz1);
mux_2 hazard2(sel_C2,rdata2,wdata,ophaz2);
mux_2 haz3(sels_a,instruction0x00000013,IRA_in);
always_comb begin
    w_in = wdata;
    rs1 = IRA_op[19:15];
    rs2 = IRA_op[24:20];
    rsd = IRB_op[11:7];
    sels_a = br_taken
end

endmodule