
module data_comb(
  input in1,in2,
  output reg out
  );
  
  reg sig;
  
 always @(*)
 begin
   sig = !in1;
   out = in2 & sig;
 end

endmodule
