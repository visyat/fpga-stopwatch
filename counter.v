module counter(
    input wire adjClk, // 1. Adjusting the clock based on ADJ and SEL
    input wire incClk, // 2. Stopwatch. Increment Counter on MIN:SEC
    // input wire fastClk, // 3. Display
    // input wire blinkClk, // 4. Blinking LED on Adjust Mode
    input reg rst,
    input reg adj,
    input reg sel,
    input reg pause,
    output reg [5:0] minutes,
    output reg [5:0] seconds
);

    reg paused = 0;

    always @(posedge incClk or posedge rst) begin
        if (rst) begin
            minutes <= 0;
            seconds <= 0;
            paused <= 0;
        end
        else if (adj == 0 && paused == 0) begin
            if (seconds == 59) begin
                seconds <= 0;
                if (minutes == 59) begin
                    minutes <= 0;
                end
                else begin
                    minutes <= minutes + 1;
                end
            end
            else begin
                seconds <= seconds + 1;
            end
        end
    end

    always @(posedge adjClk or posedge rst) begin
        if (rst) begin
            minutes <= 0;
            seconds <= 0;
            paused <= 0;
        end
        else if (adj == 1) begin
            if (sel == 0) begin // minutes adjust
                if (minutes == 59) begin
                    minutes <= 0;
                else begin
                    minutes <= minutes + 1;
                end 
            end
            else if (sel == 1) begin  // seconds adjust
                if (seconds == 59) begin
                    seconds <= 0;
                else begin
                    seconds <= seconds + 1;
                end
            end
        end
    end

    always @(posedge pause) begin
        paused <= ~paused;
    end
endmodule
