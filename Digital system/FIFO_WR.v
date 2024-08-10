
module FIFO_WR(
  input WR_CLK,WR_RST,
  input WR_INC,
  input [3:0] GRAY_RD_PTR,
  output reg [2:0] WR_ADDR,
  output reg [3:0] GRAY_WR_PTR,
  output wire WR_FULL
  );
  
  reg [3:0] WR_PTR;
  
  assign WR_FULL = ( (GRAY_WR_PTR[3] != GRAY_RD_PTR[3]) && (GRAY_WR_PTR[2] != GRAY_RD_PTR[2]) && (GRAY_WR_PTR[1:0] == GRAY_RD_PTR[1:0]) )? (1'd1):(1'd0);
  
  always @(posedge WR_CLK or negedge WR_RST)
  begin
    
    if(!WR_RST)
      begin
        WR_PTR <= 4'd0;
        WR_ADDR <= 3'd0;
      end
      
    else if(WR_INC && !WR_FULL && WR_ADDR < 3'd7)
      begin
        WR_ADDR <= WR_ADDR + 1'd1;
        WR_PTR[2:0] <= WR_PTR[2:0] +1'd1;
        WR_PTR[3] <= 1'b0;
      end
      
    else if(WR_INC && !WR_FULL && WR_ADDR == 3'd7)
      begin
        WR_ADDR <= 3'd0;
        WR_PTR[2:0] <= 3'd0;
        WR_PTR[3] <= 1'b1;
      end
      
  end

always @(*)
begin
  
  case(WR_PTR)
    4'b0000:
    begin
      GRAY_WR_PTR = 4'b0000;
    end
    
    4'b0001:
    begin
      GRAY_WR_PTR = 4'b0001;
    end
    
    4'b0010:
    begin
      GRAY_WR_PTR = 4'b0011;
    end
    
    4'b0011:
    begin
      GRAY_WR_PTR = 4'b0010;
    end
    
    4'b0100:
    begin
      GRAY_WR_PTR = 4'b0110;
    end
    
    4'b0101:
    begin
      GRAY_WR_PTR = 4'b0111;
    end
    
    4'b0110:
    begin
      GRAY_WR_PTR = 4'b0101;
    end
    
    4'b0111:
    begin
      GRAY_WR_PTR = 4'b0100;
    end
    
    4'b1000:
    begin
      GRAY_WR_PTR = 4'b1100;
    end
    
    4'b1001:
    begin
      GRAY_WR_PTR = 4'b1101;
    end
    
    4'b1010:
    begin
      GRAY_WR_PTR = 4'b1111;
    end
    
    4'b1011:
    begin
      GRAY_WR_PTR = 4'b1110;
    end
    
    4'b1100:
    begin
      GRAY_WR_PTR = 4'b1010;
    end
    
    4'b1101:
    begin
      GRAY_WR_PTR = 4'b1011;
    end
    
    4'b1110:
    begin
      GRAY_WR_PTR = 4'b1001;
    end
    
    4'b1111:
    begin
      GRAY_WR_PTR = 4'b1000;
    end
    
  endcase
  
end

endmodule

