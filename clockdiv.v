module clock(
    //Inputs
    masterClk,
    rst,
    //Outputs
    adjClk,
    incClk, 
    fastClk, 
    blinkClk
);
    input wire masterClk;
    input wire rst;
    output adjClk; // 1. Adjusting the clock based on ADJ and SEL
    output incClk; // 2. Stopwatch. Increment Counter on MIN:SEC
    output fastClk; // 3. Display
    output blinkClk; // 4. Blinking LED on Adjust Mode

    //Master Clock ==> 100 MHz 

    reg [31:0] adjCounter;
    reg [31:0] incCounter;
    reg [31:0] fastCounter;
    reg [31:0] blinkCounter;


    always @(posedge masterClk) begin
        //Adjust ==> 2 Hz
        if (rst) begin
            adjCounter <= 0;
            adjClk <= 0;
        end
        else if (adjCounter == 25000000) begin
            adjCounter <= 0;
            adjClk <= ~adjClk;
        end 
        else begin
            adjCounter <= adjCounter + 1;
        end

        //Increment ==> 1 Hz 
        if (rst) begin
            incCounter <= 0;
            incClk <= 0;
        end
        else if (incCounter == 50000000) begin
            incCounter <= 0;
            incClk <= ~incClk;
        end 
        else begin
            incCounter <= incCounter + 1;
        end

        //Fast ==> 50-700 Hz 
        if (rst) begin
            fastCounter <= 0;
            fastClk <= 0;
        end
        else if (fastCounter == 200000) begin // 250 Hz 
            fastCounter <= 0;
            fastClk <= ~fastClk;
        end 
        else begin
            fastCounter <= fastCounter + 1;
        end

        //Blink ==> 1 Hz (or greater)
        if (rst) begin
            blinkCounter <= 0;
            blinkClk <= 0;
        end
        else if (blinkCounter == 50000000) begin
            blinkCounter <= 0;
            blinkClk <= ~blinkClk;
        end 
        else begin
            blinkCounter <= blinkCounter + 1;
        end
    end
endmodule