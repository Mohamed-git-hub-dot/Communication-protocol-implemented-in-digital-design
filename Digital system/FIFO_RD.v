
module FIFO_RD(
  input RD_CLK,RD_RST,
  input RD_INC,
  input [3:0] GRAY_WR_PTR,
  output reg [2:0] RD_ADDR,
  output reg [3:0] GRAY_RD_PTR,
  output wire RD_EMPTY
  );
  
  reg [3:0] RD_PTR;
  
always @(posedge RD_CLK or negedge RD_RST)
  begin
    
    if(!RD_RST)
      begin
        RD_PTR <= 4'd0;
        RD_ADDR <= 3'd0;
      end
      
    else if(RD_INC && !RD_EMPTY && RD_ADDR < 3'd7)
      begin
        RD_ADDR <= RD_ADDR + 1'd1;
        RD_PTR[2:0] <= RD_PTR[2:0] +1'd1;
        RD_PTR[3] <= 1'b0;
      end
      
    else if(RD_INC && !RD_EMPTY && RD_ADDR == 3'd7)
      begin
        RD_ADDR <= 3'd0;
        RD_PTR[2:0] <= 3'd0;
        RD_PTR[3] <= 1'b1;
      end
      
  end


always @(*)
begin
  
  case(RD_PTR)
    4'b0000:
    begin
      GRAY_RD_PTR = 4'b0000;
    end
    
    4'b0001:
    begin
      GRAY_RD_PTR = 4'b0001;
    end
    
    4'b0010:
    begin
      GRAY_RD_PTR = 4'b0011;
    end
    
    4'b0011:
    begin
      GRAY_RD_PTR = 4'b0010;
    end
    
    4'b0100:
    begin
      GRAY_RD_PTR = 4'b0110;
    end
    
    4'b0101:
    begin
      GRAY_RD_PTR = 4'b0111;
    end
    
    4'b0110:
    begin
      GRAY_RD_PTR = 4'b0101;
    end
    
    4'b0111:
    begin
      GRAY_RD_PTR = 4'b0100;
    end
    
    4'b1000:
    begin
      GRAY_RD_PTR = 4'b1100;
    end
    
    4'b1001:
    begin
      GRAY_RD_PTR = 4'b1101;
    end
    
    4'b1010:
    begin
      GRAY_RD_PTR = 4'b1111;
    end
    
    4'b1011:
    begin
      GRAY_RD_PTR = 4'b1110;
    end
    
    4'b1100:
    begin
      GRAY_RD_PTR = 4'b1010;
    end
    
    4'b1101:
    begin
      GRAY_RD_PTR = 4'b1011;
    end
    
    4'b1110:
    begin
      GRAY_RD_PTR = 4'b1001;
    end
    
    4'b1111:
    begin
      GRAY_RD_PTR = 4'b1000;
    end
    
  endcase
  
end

assign RD_EMPTY = (GRAY_WR_PTR == GRAY_RD_PTR)? (1'd1):(1'd0);

endmodule


