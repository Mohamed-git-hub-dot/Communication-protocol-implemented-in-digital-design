

module UART_TX(
  input CLK,RST,
  input [7:0] PAR_DATA,
  input DATA_VALID,PAR_EN,PAR_TYP,
  output wire TX_OUT,BUSY
  );
  
  wire ser_en,ser_done,ser_data;
  wire [1:0] mux_sel;
  wire par_bit;
  
  TX_SERIALIZER SER(
  .CLK(CLK),
  .RST(RST),
  .P_DATA(PAR_DATA),
  .ser_en(ser_en),
  .DATA_VALID(DATA_VALID),
  .BUSY(BUSY),
  .ser_done(ser_done),
  .ser_data(ser_data)
  );
  
  TX_FSM UART(
  .CLK(CLK),
  .RST(RST),
  .ser_done(ser_done),
  .PAR_EN(PAR_EN),
  .DATA_VALID(DATA_VALID),
  .mux_sel(mux_sel),
  .ser_en(ser_en),
  .BUSY(BUSY)
  );
  
  TX_PARITY_CALC PAR(
  .CLK(CLK),
  .RST(RST),
  .DATA_VALID(DATA_VALID),
  .P_DATA(PAR_DATA),
  .BUSY(BUSY),
  .PAR_TYP(PAR_TYP),
  .par_bit(par_bit)
  );
  
  TX_MUX INST(
  .mux_sel(mux_sel),
  .ser_data(ser_data),
  .par_bit(par_bit),
  .tx_out(TX_OUT)
  );
  
endmodule
