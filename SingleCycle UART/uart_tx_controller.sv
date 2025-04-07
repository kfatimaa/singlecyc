module uart_tx_controller(
    input logic clk, reset,
    input logic baud_comp,shift_done,txfe,
    output logic cnt_en,tx_shift_en,tx_sel,tx_fifo_shift,load
);
    typedef enum {IDLE, LOAD, TRANSMIT} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
            IDLE: begin
                cnt_en        = 1'b0;
                tx_shift_en   = 1'b0;
                tx_sel        = 1'b0;
                tx_fifo_shift = 1'b0;
                load          = 1'b0;   
                if (!txfe)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            end
            LOAD: begin
                cnt_en        = 1'b0;
                tx_shift_en   = 1'b0;
                tx_sel        = 1'b0;
                tx_fifo_shift = 1'b1;
                load          = 1'b1;
                next_state    = TRANSMIT;
            end
            TRANSMIT: begin
                if (shift_done)
                    next_state = IDLE;
                else
                    next_state = TRANSMIT;
                tx_sel        = 1'b1;
                tx_fifo_shift = 1'b0;
                load          = 1'b0;
                if (baud_comp) begin
                    tx_shift_en = 1'b1;
                    cnt_en = 1'b1;
                end
                else begin
                    tx_shift_en = 1'b0;
                    cnt_en = 1'b0;
                end
            end 
        endcase
    end
endmodule