
module DATA_SYNC #(
  parameter BUS_WIDTH = 8
  )(
  input CLK,RST,
  input [BUS_WIDTH-1 : 0] unsync_bus,
  input bus_enable,
  output wire [BUS_WIDTH-1 : 0] sync_bus,
  output wire enable_pulse
  );
  
  wire signal1,signal2;
  
  data INST6(
  .CLK(CLK),
  .RST(RST),
  .bus_enable(bus_enable),
  .out(signal1)
  );
  
  PULSE INST7(
  .CLK(CLK),
  .RST(RST),
  .in(signal1),
  .out(signal2)
  );
  
  SYNC_BUS INST8(
  .CLK(CLK),
  .RST(RST),
  .unsync_bus(unsync_bus),
  .enable(signal2),
  .sync_bus(sync_bus)
  );
  
  FF INST9(
  .CLK(CLK),
  .RST(RST),
  .in(signal2),
  .out(enable_pulse)
  );
  
endmodule

