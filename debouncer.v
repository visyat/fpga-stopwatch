module debouncer(
    btn,
    sampling_clk, //use the display clock
    debounced_signal
);
    input wire btn;
    input wire sampling_clk;
    output reg debounced_signal;

    // debounced_signal = 0;
    always @ (posedge sampling_clk) begin
        debounced_signal <= btn;
    end

endmodule
