module test;
    reg clk;
    reg rst;

    reg adjClk;
    reg incClk;
    reg fastClk;
    reg blinkClk;
  
    clock Clock (
        .masterClk(clk), 
        .rst(rst), 
        .adjClk(adjClk), 
        .incClk(incClk), 
        .fastClk(fastClk), 
        .blinkClk(blinkClk)
    );

    initial begin
        $display("Resetting stopwatch");
        clk = 0;
        rst = 1;
        #10 rst = 0;
    end

    always #5 clk = ~clk;
    always @(posedge fastClk) begin
        $display("Time=%0t ns: fastClk changed to %b", $time, fastClk);
    end
  
endmodule