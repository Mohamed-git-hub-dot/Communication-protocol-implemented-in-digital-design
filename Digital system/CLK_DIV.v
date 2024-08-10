

module CLK_DIV #(
  parameter DIV_RATIO_WIDTH = 8
)(
  input i_ref_clk,i_rst_n,
  input i_clk_en,
  input [DIV_RATIO_WIDTH-1:0] i_div_ratio,
  output reg o_div_clk
  );
  
  wire odd;
  
  reg flag;
  
  reg [DIV_RATIO_WIDTH-1:0] cntr;
  
  wire [DIV_RATIO_WIDTH-1:0] half;
  wire [DIV_RATIO_WIDTH-1:0] half1;
  
  always @(posedge i_ref_clk or negedge i_rst_n)
  begin
    if(!i_rst_n)
      begin
        o_div_clk <= 1'd0;
        cntr <= 'd0;
        flag <= 1'd0;
      end
      
    else if( (i_clk_en) && (i_div_ratio != 0) && (i_div_ratio != 1) )
      begin
        if( (cntr == half) && (!odd) )
          begin
            o_div_clk <= ~o_div_clk;
            cntr <= 'd1;
          end
          
        else if( ( (cntr == half && !flag) || (cntr == half1 && flag) )  && (odd) )
          begin
            o_div_clk <= ~o_div_clk;
            flag <= !flag;
            cntr <= 'd1;
          end
          
        else
          begin
            cntr <= cntr + 'd1;
          end
          
      end
      
    else
      begin
        o_div_clk <= i_ref_clk;
      end
      
  end
  
  assign half = i_div_ratio >> 1;
  assign half1 = half + 'd1;
  assign odd = i_div_ratio[0];
  
endmodule
