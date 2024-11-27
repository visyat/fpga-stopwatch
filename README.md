# FPGA Stopwatch

Stopwatch circuit on FPGA, written in Verilog, that counts minutes and seconds up to an hour; using buttons and switches on the FPGA, we are able to pause the stopwatch, and adjust either the minutes or seconds.

```
1. Basic clock which counts minutes and seconds (e.g. 1 minute 43 seconds ⇒ 0143)
2. Adjust mode (switch activated) which enables users to increment either the minutes or seconds
3. Pause mode, in which the counter does not change, but the display blinks.
```