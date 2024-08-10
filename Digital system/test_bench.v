`timescale 1ns/1ps

module test_bench();
  
  reg RX_IN,RST;
  reg REF_CLK,UART_CLK;
  reg [7:0] UART_CONFIG;
  wire TX_OUT;
  wire framing_error,parity_error;

  parameter UART_CLK_PER = 271.26736;
  parameter REF_CLK_PER  = 10;
  
  always #(REF_CLK_PER/2)  REF_CLK  = ~ REF_CLK;
  always #(UART_CLK_PER/2) UART_CLK = ~ UART_CLK;
  
  
  SYS_TOP DUT(
  .RX_IN(RX_IN),
  .RST(RST),
  .REF_CLK(REF_CLK),
  .UART_CLK(UART_CLK),
  .UART_CONFIG(UART_CONFIG),
  .TX_OUT(TX_OUT),
  .framing_error(framing_error),
  .parity_error(parity_error)
  );
  
  initial
  begin
    
    $dumpfile("test_bench.vcd");
    $dumpvars;
    
    REF_CLK = 1'd0;
    UART_CLK = 1'd0;

    
    RESET();
    #(5)
    
    UART_CONFIG = 8'b001000_01;
    
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0; 
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    
    
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b0;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    #(UART_CLK_PER*32)
    RX_IN = 1'b1;
    
    
    #(2000*UART_CLK_PER)
    $finish;
    
  end
  
  task RESET;
  begin
    RST = 1'd1;
    #(UART_CLK_PER/2)
    RST = 1'd0;
    #(UART_CLK_PER/2)
    RST = 1'd1;
    #(UART_CLK_PER/2);
  end
endtask
  
endmodule
