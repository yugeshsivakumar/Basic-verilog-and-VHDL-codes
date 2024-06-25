//design

module mux1(a,b,sel,out);
  input a,b,sel;
  output out;
  initial
  $display("MUX_1 is instantiated");

  assign out=sel?b:a;
  
endmodule

module mux2(a,b,sel,out);
  input a,b,sel;
  output reg out;
  initial
  $display("MUX_2 is instantiated");
  always@(sel)
    begin
  case(sel)
    0: out=a;
    1: out=b;
  endcase
  end
endmodule

module gen(a,b,sel,out);
  input a,b,sel;
  output out;
  parameter mode=0;
  
  if(mode)
     mux2 m2(a,b,sel,out);
 
  else
       mux1 m1(a,b,sel,out);
  
endmodule
 
 //testbench
 
 module tb();
  reg a,b,sel;
  wire out;
  integer i;
  
  gen g1(a,b,sel,out);
  
  initial begin
    a <= 0;
    b <= 0;
    sel <= 0;
    
    for (i = 0; i < 5; i = i + 1) begin
      #10 a <= $random;
      	  b <= $random;
          sel <= $random;
      $display ("i=%0d a=0x%0h b=0x%0h sel=0x%0h out=0x%0h", i, a, b, sel, out);
    end
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
  

            
  
            
