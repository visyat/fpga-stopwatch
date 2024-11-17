module stopwatch (
    //inputs
    sw,
    clk,
    btnS,
    btnR,

    //outputs
    an,
    seg
);
    input [1:0] sw; //[0]: SEL, [1]: ADJ
    input clk;
    input btnS; // pause
    input btnR; // rst 
    
    output reg [3:0] an;
    output reg [6:0] seg;

    reg adjClk;
    reg incClk;
    reg fastClk;
    reg blinkClk;

    reg dbPause;
    reg dbRst;
    reg dbSel;
    reg dbAdj;

    reg [5:0] min;
    reg [5:0] sec;

    clock inst_clk (
        .masterClk(clk),
        .rst(btnR),
        .adjClk(adjClk),
        .incClk(incClk), 
        .fastClk(fastClk), 
        .blinkClk(blinkClk)
    );

    /* handling of debounced signals needs to be debugged? */
    buttonDebouncer pause_inst (
        .btn(btnS), 
        .sampling_clk(fastClk),
        .rising_debounced_signal(dbPause)
    );
    buttonDebouncer reset_inst (
        .btn(btnR), 
        .sampling_clk(fastClk),
        .rising_debounced_signal(dbRst)
    );
    debouncer sel_inst (
        .btn(sw[0]),
        .sampling_clk(fastClk),
        .debounced_signal(dbSel)
    );  
    debouncer adj_inst (
        .btn(sw[1]),
        .sampling_clk(fastClk),
        .debounced_signal(dbAdj)
    );

    counter inst_cntr (
        .adjClk(adjClk),
        .incClk(incClk),
        .rst(dbRst),
        .sel(dbSel),
        .adj(dbAdj),
        .pause(dbPause),
        .minutes(min),
        .seconds(sec)
    );
    display inst_display (
        .minutes(min),
        .seconds(sec),
        .fastClk(fastClk),
        .blinkClk(blinkClk),
        .pause(dbPause),
        .reset(dbRst),
        .anodeActivate(an),
        .LED_out(seg)
    );
    
    // not fully confident what this always block is for
    /*
    always @(fastClk) begin
        if (dbPause) begin
            dbPause <= ~paused;
        end
        else if (reset) begin
             paused <= 0;
        end
    end
    */

endmodule
