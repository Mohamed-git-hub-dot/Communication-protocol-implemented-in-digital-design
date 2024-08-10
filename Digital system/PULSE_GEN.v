
module PULSE_GEN(
  input CLK,RST,
  input LVL_SIG,
  output wire PULSE_SIG
  );
  
 reg sig1,sig2;
 
 always @(posedge CLK or negedge RST)
 begin
   
   if(!RST)
     begin
       sig1 <= 1'd0;
       sig2 <= 1'd0;
     end
     
   else
     begin
       sig1 <= LVL_SIG;
       sig2 <= sig1;
     end
     
 end 
 
 assign PULSE_SIG = (sig1) && (!sig2);
  
  
endmodule
