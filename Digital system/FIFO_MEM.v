
module FIFO_MEM #(
  parameter DATA_WIDTH = 8
)(
  input WR_CLK,
  input [DATA_WIDTH-1 : 0] WR_DATA,
  input WR_INC,WR_FULL,
  input [2:0] WR_ADDR,RD_ADDR,
  output wire [DATA_WIDTH-1 : 0] RD_DATA 
);

reg [DATA_WIDTH-1 : 0] memory [0 : 7];

always @(posedge WR_CLK)
begin
  
  if(WR_INC && !WR_FULL)
    begin
      memory[WR_ADDR] <= WR_DATA;
    end
  
end

assign RD_DATA = memory[RD_ADDR];

endmodule 
