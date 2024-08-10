
module PULSE(
  input CLK,RST,
  input in,
  output wire out
  );
  
  wire signal;
  
  FF INST3(
  .CLK(CLK),
  .RST(RST),
  .in(in),
  .out(signal)
  );
  
  data_comb INST10(
  .in1(signal),
  .in2(in),
  .out(out)
  );
  
endmodule

