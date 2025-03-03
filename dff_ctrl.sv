module dff_ctrl(
    input logic reg_wr,rd_en,wr_en,
    input logic [1:0] wb_sel,
    output logic reg_wrff,rd_enff,wr_enff,
     output logic [1:0] wb_selff

);

always_ff @ (posedge clk or posedge reset)
begin
    if (reset) begin
        wb_selff<=  2'b0;
        reg_wrff<=  1'b0;
        rd_enff<=  1'b0;
        wr_enff<=  1'b0;
    end
    else begin
        wb_selff<= wb_sel ;
        reg_wrff<=  reg_wr;
        rd_enff<=   rd_en;
        wr_enff<=  wr_en;
    end
            
    end


endmodule



