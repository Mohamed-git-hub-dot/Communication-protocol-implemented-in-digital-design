
module FF #(
  parameter BUS_WIDTH = 1
  )(
  input CLK,RST,
  input [BUS_WIDTH-1 : 0] in,
  output reg [BUS_WIDTH-1 : 0] out
  );
  
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        out <= 'd0;
      end
      
    else
      begin
        out <= in;
      end
      
  end

endmodule
