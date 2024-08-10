
module SYS_CTRL #(
  parameter DATA_WIDTH = 8,
  parameter RF_ADDR = 4
  )(
  input CLK,RST,
  input FIFO_FULL,
  input [DATA_WIDTH-1:0] SYNC_RX_P_DATA,
  input SYNC_RX_VALID,
  input ALU_OUT_VALID,
  input [15:0] ALU_OUT,
  input [DATA_WIDTH-1:0] RD_D,
  input RD_D_VALID,
  output reg WR_EN,RD_EN,
  output reg [RF_ADDR-1:0] ADDR,
  output reg [DATA_WIDTH-1:0] WR_D,
  output reg GATE_EN,ALU_EN,
  output reg [3:0] ALU_FUN,
  output reg WR_INC,
  output reg [DATA_WIDTH-1:0] WR_DATA
  );
  
  parameter [3:0] IDLE          = 4'd0,
                  RF_WR_ADDR    = 4'd1,
                  RF_WR_DATA    = 4'd2,
                  RF_RD_ADDR    = 4'd3,
                  OPERAND_A     = 4'd4,
                  OPERAND_B     = 4'd5,
                  ALU_FUN_1     = 4'd6,
                  WAIT_VALID    = 4'd7,
                  VALID_ALU_OUT = 4'd8,
                  FIFO          = 4'd9;
  
  reg [3:0] curr_state,next_state;
  
  reg [RF_ADDR-1:0] ADDRESS;
  reg E;
  
  
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
    
    E = 1'd0;
    WR_EN = 1'd0;
    RD_EN = 1'd0;
    ADDR = 'd0;
    WR_D = 'd0;
    GATE_EN = 1'd0;
    ALU_EN = 1'd0;
    ALU_FUN = 'd0;
    WR_INC = 1'd0;
    WR_DATA = 'd0;
    
    case(curr_state)
      IDLE:
      begin
        if( (SYNC_RX_VALID) && (SYNC_RX_P_DATA == 'hAA) )
          begin
            next_state = RF_WR_ADDR;
          end
        else if( (SYNC_RX_VALID) && (SYNC_RX_P_DATA == 'hBB) )
          begin
            next_state = RF_RD_ADDR;
          end
        else if( (SYNC_RX_VALID) && (SYNC_RX_P_DATA == 'hCC) )
          begin
            next_state = OPERAND_A;
          end
        else if( (SYNC_RX_VALID) && (SYNC_RX_P_DATA == 'hDD) )
          begin
            next_state = ALU_FUN_1;
          end
        else
          begin
            next_state = IDLE;
          end
      end
      
      RF_WR_ADDR:
      begin
        if( (SYNC_RX_VALID) )
          begin
            E = 1;
            ADDR = SYNC_RX_P_DATA;
            next_state = RF_WR_DATA;
          end
        else
          begin
            next_state = RF_WR_ADDR;
          end
      end
      
      RF_WR_DATA:
      begin
        if( (SYNC_RX_VALID) )
          begin
            WR_EN = 1'd1;
            WR_D = SYNC_RX_P_DATA;
            ADDR = ADDRESS;
            next_state = IDLE;
          end
        else
          begin
            next_state = RF_WR_DATA;
          end
      end
      
      RF_RD_ADDR:
      begin
        if( (SYNC_RX_VALID) )
          begin
            E = 1;
            ADDR = SYNC_RX_P_DATA;
            next_state = WAIT_VALID;
          end
        else
          begin
            next_state = RF_RD_ADDR;
          end
      end
      
      WAIT_VALID:
      begin
            RD_EN = 1'd1;
            ADDR = ADDRESS;
            
            if(RD_D_VALID)
              begin
                next_state = FIFO;
              end
            else
              begin
                next_state = WAIT_VALID;
              end
      end
      
      FIFO:
      begin
        if(!FIFO_FULL)
          begin
            WR_INC = 1'd1;
            WR_DATA = RD_D;
            next_state = IDLE;
          end
        else
          begin
            next_state = FIFO;
          end
      end
      
      OPERAND_A:
      begin
        if( (SYNC_RX_VALID) )
          begin
            WR_EN = 1'd1;
            WR_D = SYNC_RX_P_DATA;
            ADDR = 'd0;
            next_state = OPERAND_B;
          end
        else
          begin
            next_state = OPERAND_A;
          end
      end
      
      OPERAND_B:
      begin
        if( (SYNC_RX_VALID) )
          begin
            WR_EN = 1'd1;
            WR_D = SYNC_RX_P_DATA;
            ADDR = 'd1;
            next_state = ALU_FUN_1;
          end
        else
          begin
            next_state = OPERAND_B;
          end
      end
      
      ALU_FUN_1:
      begin
        if( (SYNC_RX_VALID) )
          begin
            ALU_EN = 1'd1; 
            GATE_EN = 1'd1;
            ALU_FUN = SYNC_RX_P_DATA;
            next_state = VALID_ALU_OUT;
          end
        else
          begin
            next_state = ALU_FUN_1;
          end
      end
      
      VALID_ALU_OUT:
      begin
        GATE_EN = 1'd1;
        if(ALU_OUT_VALID && !FIFO_FULL)
          begin
            WR_DATA = ALU_OUT[7:0];
            WR_INC = 1'd1;
            next_state = IDLE;
          end
        else
          begin
            next_state = VALID_ALU_OUT;
          end
      end
      
      default:
      begin
        E = 1'd0;
        WR_EN = 1'd0;
        RD_EN = 1'd0;
        ADDR = 'd0;
        WR_D = 'd0;
        GATE_EN = 1'd0;
        ALU_EN = 1'd0;
        ALU_FUN = 'd0;
        WR_INC = 1'd0;
        WR_DATA = 'd0;
        next_state = IDLE;
      end
  
  endcase 

end 
  
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        ADDRESS <= 'd0;
      end
    else if(E)
      begin
        ADDRESS <= SYNC_RX_P_DATA;
      end
  end
  
endmodule
