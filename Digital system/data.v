
module data(
  input CLK,RST,
  input bus_enable,
  output wire out
  );
  
wire signal;

FF INST1(
.CLK(CLK),
.RST(RST),
.in(bus_enable),
.out(signal)
);

FF INST2(
.CLK(CLK),
.RST(RST),
.in(signal),
.out(out)
);

endmodule
