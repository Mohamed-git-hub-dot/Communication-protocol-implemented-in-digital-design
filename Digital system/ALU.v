
module ALU #(
  parameter DATA_WIDTH = 8,
  parameter FUN_WIDTH = 4
  )(
  input CLK,RST,
  input [DATA_WIDTH-1:0] A,
  input [DATA_WIDTH-1:0] B,
  input [FUN_WIDTH-1:0] ALU_FUN,
  input ENABLE,
  output reg [2*DATA_WIDTH-1:0] ALU_OUT,
  output reg OUT_VALID
  );
  
  reg [2*DATA_WIDTH-1:0] RES;
  reg VALID;
  
always @(*)
  begin 
     
   if(ENABLE)
     begin  
      case(ALU_FUN)
      
      'd0:
      begin
        RES = A + B;
        VALID = 1'd1;
      end
        
      'd1:
      begin
        RES = A - B;
        VALID = 1'd1;
      end
        
      'd2:
      begin
        RES = A * B;
        VALID = 1'd1;
      end
      
      'd3:
      begin
        RES = A / B;
        VALID = 1'd1;
      end
      
      'd4:
      begin
        RES = A & B;
        VALID = 1'd1;
      end
      
      'd5:
      begin
        RES = A | B;
        VALID = 1'd1;
      end
      
      'd6:
      begin
        RES = ~(A & B);
        VALID = 1'd1;
      end
      
      'd7:
      begin
        RES = ~(A | B);
        VALID = 1'd1;
      end
      
      'd8:
      begin
        RES = A ^ B;
        VALID = 1'd1;
      end
      
      'd9:
      begin
        RES = ~(A ^ B);
        VALID = 1'd1;
      end
      
      'd10:
      begin
        if(A == B)
          begin
          RES = 'd1;
          VALID = 1'd1;
          end
        else
          begin
          RES = 'd0;
          VALID = 1'd1;
          end
      end
      
      'd11:
      begin
        if(A > B)
          begin
          RES = 'd1;
          VALID = 1'd1;
          end
        else
          begin
          RES = 'd0;
          VALID = 1'd1;
          end
      end
      
      'd12:
      begin
        RES = A >> 1;
        VALID = 1'd1;
      end
      
      'd13:
      begin
        RES = A << 1;
        VALID = 1'd1;
      end
      
      default:
      begin
        RES = 'd0;
        VALID = 1'd0;
      end
      
    endcase
  end
  
else
  begin
    VALID = 1'd0;
  end
    
  end
  
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        ALU_OUT <= 'd0;
        OUT_VALID <= 1'd0;
      end
      
    else
      begin
        ALU_OUT <= RES;
        OUT_VALID <= VALID;
      end
      
  end
  
endmodule

