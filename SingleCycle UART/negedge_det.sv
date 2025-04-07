module negedge_det(
    input logic clk,reset,line,
    output logic detect
);

logic line1;
d_ff D1(clk,reset,1'b1,line,line1);

assign detect = (line1)&(!line);


endmodule