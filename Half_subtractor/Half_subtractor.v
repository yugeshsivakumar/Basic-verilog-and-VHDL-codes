//design

module sub(input a,b,
           output reg diff,borrow);
  always@(a,b)
    begin
      diff=a^b;
      borrow=~a&b;
    end
endmodule

//testbench

module tb;
  reg a,b;
  wire diff,borrow;
  integer i;
  sub sb1(a,b,diff,borrow);
   initial begin
      a<=0;
      b<=0;
     $monitor("%0t a=%b b=%b Difference=%b Borrow=%b",$time,a,b,diff,borrow);

       for (i=0;i<4;i++)
         begin
           {a,b}=i;
           #10;
         end
     end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
endmodule
         
       
  
  
        
