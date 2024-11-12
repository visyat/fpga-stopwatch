module stopwatch (
    //Inputs
    sw,
    clk,
    btnS,
    btnR,

    //Outputs
    an,
    seg
);

    input [1:0] sw; //[0]: SEL, [1]: ADJ
    input clk;
    input btnS; //Pause
    input btnR; //Reset 
    
    output reg [3:0] an;
    output reg [6:0] seg;

    reg adjClk;
    reg incClk;
    reg fastClk;
    reg blinkClk;

    // reg dPause;
    // reg dReset;

    reg [5:0] min;
    reg [5:0] sec;

    clockMod clock (
        .masterClk(clk),
        .rst(btnR),
        .adjClk(adjClk),
        .incClk(incClk), 
        .fastClk(fastClk), 
        .blinkClk(blinkClk)
    );

    // debouncePause buttonDebouncer (
    //     .btn(btnS), 
    //     .sampling_clk(fastClk),
    //     .rising_debounced_signal()
    // );

    // debounceReset buttonDebouncer (
    //     .btn(), 
    //     .sampling_clk(),
    //     .rising_debounced_signal()
    // );

    countMod count (
        .adjClk(adjClk),
        .incClk(incClk),
        .rst(btnR),
        .sel(sw[0]),
        .adj(sw[1]),
        .pause(btnS),
        .minutes(min),
        .seconds(sec)
    );

    displayMod display (
        .minutes(min),
        .seconds(sec),
        .incClk(incClk),
        .fastClk(fastClk),
        .blinkClk(blinkClk),
        .adj(sw[1]),
        .sel(sw[0]),
        .pause(btnS),
        .reset(btnR),
        .anodeActivate(an),
        .LED_out(seg)
    );
);

endmodule

