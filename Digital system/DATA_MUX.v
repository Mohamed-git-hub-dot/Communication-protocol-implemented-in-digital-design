
module DATA_MUX #(
  parameter BUS_WIDTH = 8
  )(
  input [BUS_WIDTH-1 : 0] in1,in2,
  input sel,
  output reg [BUS_WIDTH-1 : 0] out
  );
  
  always @(*)
  begin
    
    case(sel)
      1'd0:
      begin
        out = in1; 
      end
      
      1'd1:
      begin
        out = in2; 
      end
      
    endcase
    
  end
  
endmodule

