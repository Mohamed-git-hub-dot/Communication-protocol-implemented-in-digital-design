

module RST_SYNC(
  input CLK,RST,
  output SYNC_RST 
  );
  
  wire sig;
  
  reset_sync INST1(
  .CLK(CLK),
  .RST(RST),
  .in(1'd1),
  .out(sig)
  );
  
  
  reset_sync INST2(
  .CLK(CLK),
  .RST(RST),
  .in(sig),
  .out(SYNC_RST)
  );
  
endmodule
