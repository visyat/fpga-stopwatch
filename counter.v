module counter(
    input wire adjClk, // 1. Adjusting the clock based on ADJ and SEL
    input wire incClk, // 2. Stopwatch. Increment Counter on MIN:SEC
    // input wire fastClk, // 3. Display
    // input wire blinkClk, // 4. Blinking LED on Adjust Mode
    input wire rst,
    input wire adj,
    input wire sel,
    input wire pause,
    output reg [5:0] minutes,
    output reg [5:0] seconds
);

    reg [5:0] adj_minutes;
    reg [5:0] adj_seconds;

    always @(posedge incClk or posedge rst) begin
        if (rst) begin
            minutes <= 0;
            seconds <= 0;
        end else if (adj == 0 && pause == 0) begin
            if (seconds == 59) begin
                seconds <= 0;
                if (minutes == 59) begin
                    minutes <= 0;
                end else begin
                    minutes <= minutes + 1;
                end
            end else begin
                seconds <= seconds + 1;
            end
        end else begin
            minutes <= adj_minutes;
            seconds <= adj_minutes;
        end 
    end

    always @(posedge adjClk) begin
        if (adj == 1) begin
            if (sel == 0) begin // minutes adjust
                if (adj_minutes == 59) begin
                    adj_minutes <= 0;
                end else begin
                    adj_minutes <= adj_minutes + 1;
                end 
            end
            else if (sel == 1) begin  // seconds adjust
                if (adj_seconds == 59) begin
                    adj_seconds <= 0;
                end else begin
                    adj_seconds <= adj_seconds + 1;
                end
            end
        end else begin
            adj_minutes <= minutes;
            adj_seconds <= seconds;
        end
    end
endmodule