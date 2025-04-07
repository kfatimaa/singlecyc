module shift_reg_12(
    input logic clk,reset,load,en,
    input logic a1,
    input logic [11:0] qin,
    output logic o1,
    output logic [11:0] qout
);  
    always_ff @(negedge clk or posedge reset) begin
        if (reset) begin
            qout <= 12'b0;
            o1 <= 1'b1;
        end
        else if (load) begin
            qout <= qin;
            o1 <= 1'b1;
        end
        else if (en) begin
            o1 <= qout[0]; 
            qout[0] <= qout[1];
            qout[1] <= qout[2];
            qout[2] <= qout[3];
            qout[3] <= qout[4];
            qout[4] <= qout[5];
            qout[5] <= qout[6];
            qout[6] <= qout[7];
            qout[7] <= qout[8];
            qout[8] <= qout[9];
            qout[9] <= qout[10];
            qout[10] <= qout[11];
            qout[11] <= a1;
        end
    end



endmodule