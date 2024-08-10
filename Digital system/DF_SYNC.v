
module DF_SYNC(
  input CLK,RST,
  input [3:0] IN,
  output reg [3:0] out
  );
  
  reg [3 : 0] Q;
  
  always @(posedge CLK or negedge RST)
  begin
    
    if(!RST)
      begin
        out <= 3'd0;
        Q <= 3'd0;
      end
      
    else
      begin
        Q <= IN;
        out <= Q;
      end
      
  end
  
  
endmodule

