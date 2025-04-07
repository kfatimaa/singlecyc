module inst_mem(
    input logic [31:0] address,
    output logic [31:0] instruction
);
    logic [31:0] instruction_memory [0:1023];

    initial begin
    //$readmemh("D:/KAAM/COURSE/SEMESTER_6/Computer_Architecture/Lab/Test/build/main.txt", instruction_memory);
    instruction_memory[0] = 32'h000032B7; // r5 <--- 3
    instruction_memory[1] = 32'h8B028293;
    //instruction_memory[3] = 32'h00000013; // r5<-2
    //instruction_memory[1] = 32'h00318293; // r5<-2    
    instruction_memory[2] = 32'h06502723; // data[110]  <---- r5  baud_div

    instruction_memory[3] = 32'h00218293; // r5<-2
    instruction_memory[4] = 32'h065027A3; // data[111]  <---- r5  config_r






    instruction_memory[5] = 32'h0B618293; // r5<-b6
    instruction_memory[6] = 32'h06502823; // data[112]  <-----r5  data_r

    instruction_memory[7] = 32'h04218293; //42
    instruction_memory[8] = 32'h06502823;

    instruction_memory[9] = 32'h03918293; //39
    instruction_memory[10] = 32'h06502823;

    instruction_memory[11] = 32'h0d818293;//d8
    instruction_memory[12] = 32'h06502823;

    instruction_memory[13] = 32'h01a18293;//1a
    instruction_memory[14] = 32'h06502823;

    instruction_memory[15] = 32'h09718293;//97
    instruction_memory[16] = 32'h06502823;

	end

    assign instruction = instruction_memory[address[11:2]];

endmodule