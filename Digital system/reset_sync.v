
module reset_sync(
  input CLK,RST,
  input in,
  output reg out
  );
  
  
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        out <= 1'd0;
      end
      
    else
      begin
        out <= in;
      end
      
  end
  
endmodule