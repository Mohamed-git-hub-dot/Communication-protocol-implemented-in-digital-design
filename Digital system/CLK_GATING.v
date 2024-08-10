
module CLK_GATING(
  input CLK,
  input CLK_EN,
  output wire GATED_CLK
  );
  
  reg en;
  
  always @(*)
  begin
    if(!CLK)
      begin
        en <= CLK_EN;
      end
    else
      begin
        en <= en;
      end
  end
  
  assign GATED_CLK = en & CLK;
  
endmodule
