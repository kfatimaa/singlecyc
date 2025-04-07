module uart_rx_controller(
    input logic clk,reset,
    input logic rx_en,baud_comp,valid_in,shift_done,
    output logic rx_sel,rx_shift_en,cnt_en,valid_out,idle,ready
    );
    typedef enum {IDLE, READY , SHIFT , OUT} state_t;
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
                idle          = 1'b1;
                ready         = 1'b0;
                cnt_en        = 1'b0;
                rx_shift_en   = 1'b0;
                rx_sel        = 1'b0;
                valid_out     = 1'b0;
                if (rx_en)
                    next_state = READY;
                else
                    next_state = IDLE;  
            end
            READY: begin
                idle          = 1'b0;
                ready         = 1'b1;
                cnt_en        = 1'b0;
                rx_shift_en   = 1'b0;
                rx_sel        = 1'b1;
                valid_out     = 1'b0;
                if(valid_in)
                    next_state = SHIFT;
                else 
                    next_state = READY;
            end
            SHIFT: begin
                idle          = 1'b0;
                ready         = 1'b0;
                valid_out     = 1'b0;
                if (shift_done)
                    next_state = OUT;
                else 
                    next_state = SHIFT;
                rx_sel        = 1'b1;
                if (baud_comp) begin
                    rx_shift_en = 1'b1;
                    cnt_en = 1'b1;
                end
                else begin
                    rx_shift_en = 1'b0;
                    cnt_en = 1'b0;
                end
            end
            OUT: begin
                idle          = 1'b0;
                ready         = 1'b0;
                valid_out     = 1'b1;
                cnt_en        = 1'b0;
                rx_shift_en   = 1'b0;
                rx_sel        = 1'b1;
                next_state = READY;
            end 
        endcase
    end
endmodule