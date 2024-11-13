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
    
    output wire [3:0] an;
    output wire [6:0] seg;

    wire adjClk;
    wire incClk;
    wire fastClk;
    wire blinkClk;
    reg paused;
    wire pause;
    wire reset;
    wire ADJ;
    wire SEL;

    // reg dPause;
    // reg dReset;

    wire [5:0] min;
    wire [5:0] sec;

    clock inst_clk (
        .masterClk(clk),
        .rst(reset),
        .adjClk(adjClk),
        .incClk(incClk), 
        .fastClk(fastClk), 
        .blinkClk(blinkClk)
    );

     buttonDebouncer pause_inst (
         .btn(btnS), 
         .sampling_clk(fastClk),
         .rising_debounced_signal(pause)
     );
     
     buttonDebouncer reset_inst (
              .btn(btnR), 
              .sampling_clk(fastClk),
              .rising_debounced_signal(reset)
          );
     
     debouncer sel_inst (
          .btn(sw[0]),
          .sampling_clk(fastClk),
          .debounced_signal(SEL)
      );
      
      debouncer adj_inst (
           .btn(sw[1]),
           .sampling_clk(fastClk),
           .debounced_signal(ADJ)
       );

    counter inst_cntr (
        .adjClk(adjClk),
        .incClk(incClk),
        .rst(reset),
        .sel(SEL),
        .adj(ADJ),
        .paused(paused),
        .minutes(min),
        .seconds(sec)
    );

    display inst_display (
        .minutes(min),
        .seconds(sec),
        .fastClk(fastClk),
        .blinkClk(blinkClk),
        .paused(paused),
        .reset(reset),
        .anodeActivate(an),
        .LED_out(seg)
    );
    
    always @(fastClk) begin
        if (pause) begin
            paused <= ~paused;
        end
        else if (reset) begin
             paused <= 0;
        end
    end

endmodule

