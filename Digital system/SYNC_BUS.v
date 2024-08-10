
module SYNC_BUS #(
  parameter BUS_WIDTH = 8
  )(
  input CLK,RST,
  input [BUS_WIDTH-1 : 0] unsync_bus,
  input enable,
  output wire [BUS_WIDTH-1 : 0] sync_bus
  );
  
  wire [BUS_WIDTH-1 : 0] signal;
  
  DATA_MUX INST4(
  .in1(sync_bus),
  .in2(unsync_bus),
  .sel(enable),
  .out(signal)
  );
  
  FF #(.BUS_WIDTH(8)) INST5(
  .CLK(CLK),
  .RST(RST),
  .in(signal),
  .out(sync_bus)
  );
  
endmodule

