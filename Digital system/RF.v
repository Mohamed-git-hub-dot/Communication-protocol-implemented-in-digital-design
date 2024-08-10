

module RF #(
  parameter DATA_WIDTH = 8,
  parameter ADDRESS_WIDTH = 4,
  parameter DEPTH = 16
  )(	
  input CLK,RST,
  input WR_EN,RD_EN,
  input PAR_EN,PAR_TYP,
  input [4:0] prescale,
  input [ADDRESS_WIDTH - 1:0] address,
  input [DATA_WIDTH - 1:0] WR_DATA,
  output reg [DATA_WIDTH - 1:0] RD_DATA,
  output reg RdData_valid,
  output wire [DATA_WIDTH - 1:0] REG0,REG1,REG2,REG3
  );
  
  reg [DATA_WIDTH-1:0] register [0:DEPTH-1];
  
  integer i;
  
  always @(posedge CLK or negedge RST)
   begin
     
     if(!RST)
       begin
         
         RD_DATA <= 'd0;
         RdData_valid <= 1'd0;
         
         for(i=0;i<=DEPTH-1;i=i+1)
         begin
           if(i == 2)
             begin
               register[i] <= 'b001000_01;
             end
           else if(i == 3)
             begin
               register[i] <= 'd32;
             end
           else 
             begin
               register[i] <= 'd0;
             end
         end
       end
       
     else if( (WR_EN == 1) && (RD_EN == 0) )
       begin
         register[address] <= WR_DATA;
         RdData_valid <= 1'd0;
         
         register[2][0]   <= PAR_EN;
         register[2][1]   <= PAR_TYP;
         register[2][7:2] <= prescale;
       end
       
     else if( (WR_EN == 0) && (RD_EN == 1) ) 
       begin
         RD_DATA <= register[address];
         RdData_valid <= 1'd1;
         
         register[2][0]   <= PAR_EN;
         register[2][1]   <= PAR_TYP;
         register[2][7:2] <= prescale;
       end
       
     else
       begin
         RdData_valid <= 1'd0;
       end
       
   end
   
   assign REG0 = register[0];
   assign REG1 = register[1];
   assign REG2 = register[2];
   assign REG3 = register[3];
  
endmodule

