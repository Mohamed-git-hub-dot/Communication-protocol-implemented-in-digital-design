
module TX_SERIALIZER(
  input CLK,RST,
  input [7:0] P_DATA,
  input ser_en,
  input DATA_VALID,BUSY,
  output reg ser_done,ser_data 
  );
  
  reg [3:0] cntr;
  
  reg [7:0] V_DATA;
  
  always @(posedge CLK or negedge RST)
  begin
    
    if(!RST)
      begin
        ser_done <= 1'd0;
        ser_data <= 1'd1;
        cntr <= 4'd0;
        V_DATA <= 'd0;
      end
     
    else if(DATA_VALID && !BUSY)
    begin
      V_DATA <= P_DATA;
    end 
      
    else if(ser_en && cntr != 4'd8)
      begin
        ser_data <= V_DATA[cntr];
        cntr <= cntr + 4'd1;
        
        if(cntr == 4'd7)
          begin
           ser_done <= 1'd1;
          end
      end
      
    else 
      begin
        ser_done <= 1'd0;
        ser_data <= 1'd1;
        cntr <=  4'd0;
      end
      
  end 
  
endmodule

