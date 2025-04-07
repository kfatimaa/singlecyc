module mux2_1b(
    input logic s,
    input logic a0,a1,
    output logic  y
);
    always_comb begin
        case(s)
        1'b0:  y = a0;
        1'b1:  y = a1;
        endcase
    end 

endmodule