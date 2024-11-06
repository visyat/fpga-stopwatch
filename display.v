module display(
    //Inputs
    minutes,
    seconds,
    incClk,
    fastClk,
    blinkClk,
    adj,
    sel,
    pause,
    reset,

    //Outputs
    anodeActivate,
    LED_out
); 
    input [5:0] minutes;
    input [5:0] seconds;

    input reset;
    input incClk;
    input fastClk;
    input blinkClk;

    input adj;
    input sel;
    input pause;

    output reg [3:0] anodeActivate;
    output reg [6:0] LED_out;

    reg [3:0] LED_BCD;
    wire [1:0] digitSelect;
    reg [1:0] digitCounter;

    always @(posedge fastClk or posedge reset) begin
        if (reset)
            digitCounter <= 2'b00;
        else
            digitCounter <= digitCounter + 1;
    end

    always @(*) begin
    // when in adjust mode and pause mode, the minutes and seconds will change based on counter module 
    // only thing need to account for is blinking in pause mode
        case (digitSelect)
            2'b00: begin
                anodeActivate = 4'b0111;
                LED_BCD = minutes/10;
            end
            2'b01: begin
                anodeActivate = 4'b1011;
                LED_BCD = minutes%10;
            end
            2'b10: begin
                anodeActivate = 4'b1101;
                LED_BCD = seconds/10;
            end
            2'b11: begin
                anodeActivate = 4'b1110;
                LED_BCD = seconds%10;
            end
        endcase
    end

    always @(*) begin
        case(LED_BCD)
            4'b0000: LED_out = 7'b0000001; // "0"     
            4'b0001: LED_out = 7'b1001111; // "1" 
            4'b0010: LED_out = 7'b0010010; // "2" 
            4'b0011: LED_out = 7'b0000110; // "3" 
            4'b0100: LED_out = 7'b1001100; // "4" 
            4'b0101: LED_out = 7'b0100100; // "5" 
            4'b0110: LED_out = 7'b0100000; // "6" 
            4'b0111: LED_out = 7'b0001111; // "7" 
            4'b1000: LED_out = 7'b0000000; // "8"     
            4'b1001: LED_out = 7'b0000100; // "9" 
            default: LED_out = 7'b0000001; // "0"
        endcase
    end

    always @(posedge blinkClk) begin
        if (pause) begin
            anodeActivate = 4'b1111;
        end
    end

endmodule