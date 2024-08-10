
module TX_FSM(
  input CLK,RST,
  input ser_done,
  input PAR_EN,
  input DATA_VALID,
  output reg [1:0] mux_sel,
  output reg ser_en,
  output reg BUSY
  );
  
  parameter [2:0] IDLE = 3'b000,
                  START = 3'b001,
                  DATA = 3'b010,
                  PARITY = 3'b011,
                  STOP = 3'b100;
                   
  reg [2:0] curr_state,next_state;
  
  wire flag;
  
  reg busy_c;
  
  always @(posedge CLK or negedge RST)
  begin
    
    if(!RST)
      begin
        curr_state <= IDLE;
      end
      
    else
      begin
        curr_state <= next_state;
      end
  end
  
  always @(*)
  begin
    
    case(curr_state)
      
      IDLE:
      begin
        busy_c = 1'd0;
        ser_en = 1'd0;
        mux_sel = 2'b01;
        
       if(DATA_VALID && flag)
         begin 
           next_state = START;
         end 
       else
         begin
           next_state = IDLE;
         end
      end
      
      START:
      begin
        mux_sel = 2'b00;
        busy_c = 1'd1;
        ser_en = 1'd1;
        next_state = DATA;
      end
      
      DATA:
      begin
        ser_en = 1'd1;
        busy_c = 1'd1;
        mux_sel = 2'b10;
           
        if(ser_done && PAR_EN)
          begin
           next_state = PARITY; 
          end
        else if(ser_done && !PAR_EN)
          begin
           next_state = STOP;
          end  
        else
          begin
            next_state = DATA;
          end
      end
      
      PARITY:
      begin
        mux_sel = 2'b11;
        busy_c = 1'd1;
        ser_en = 1'd0;
        next_state = STOP;
      end
      
      STOP:
      begin
        busy_c = 1'd1;
        ser_en = 1'd0;
        mux_sel = 2'b01;
        
        if(DATA_VALID)
          begin
            next_state = START;
          end
        else
          begin
            next_state = IDLE;
          end
      end
      
      default:
      begin
        mux_sel = 2'b10;
        busy_c = 1'd0;
        ser_en = 1'd0;
        next_state = IDLE;
      end
      
    endcase
    
  end
  
  assign flag = (DATA_VALID && !BUSY)? (1'd1):(1'd0);
  
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        BUSY <= 1'd0;
      end
    else
      begin
        BUSY <= busy_c;
      end
  end
  
endmodule

