module halfadder (input a,b,
                  output sum,carry);
  
  assign sum=a^b;
  assign carry = a&b;
endmodule;



//Testbench

module tb;
  reg a,b;
  wire sum,carry;
  integer i;
  halfadder ha1(.a(a),.b(b),.sum(sum),.carry(carry));
   initial begin
      a<=0;
      b<=0;
     $monitor("%0t a=%b b=%b sum=%b,carry=%b",$time,a,b,sum,carry);

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
         
       
  
  
        
