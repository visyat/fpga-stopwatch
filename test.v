module test;
    reg clk;
    reg rst;
    reg pause; 
    reg [1:0] sw;

    reg [3:0] an;
    reg [6:0] seg;

    integer i;
  
    stopwatch stopwatch_mod(
        .sw(sw),
        .clk(clk),
        .btnS(pause),
        .btnR(rst),
        .an(an),
        .seg(seg)
    );

    initial begin
        clk = 0;
        rst = 1;
        pause = 0;
        sw = 2'b00;
    end
    always #5 clk = ~clk;
  
endmodule