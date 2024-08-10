
module TX_PARITY_CALC(
  input CLK,RST,
  input DATA_VALID,
  input [7:0] P_DATA,
  input BUSY,
  input PAR_TYP,
  output reg par_bit
  );
  
  parameter EVEN_PAR = 1'b0,
            ODD_PAR = 1'b1;
            
  reg [7:0] V_DATA;
  reg flag;
            
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
       par_bit <= 1'd0;
       V_DATA <= 'd0;
       flag <= 1'd0;
      end
      
    else if(DATA_VALID && !BUSY)
      begin  
       V_DATA <= P_DATA;
       flag <= 1'd1;
      end
       
    else if(DATA_VALID && PAR_TYP == EVEN_PAR && flag)
      begin
       par_bit <= ^V_DATA;
       flag <= 1'd0;
      end
      
    else if(DATA_VALID && PAR_TYP == ODD_PAR && flag)
      begin
       par_bit <= ~^V_DATA;
       flag <= 1'd0;
      end
      
  end
  
endmodule

