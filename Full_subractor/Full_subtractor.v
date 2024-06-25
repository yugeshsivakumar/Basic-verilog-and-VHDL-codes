//design

module fsub(a,b,bin,diff,borrow);
  input a,b,bin;
  output reg diff,borrow;
  
  always@(a,b,bin)
    begin
      diff=a^b^bin;
      borrow=(~a&b)|(~a&bin)|(bin&b);
    end
endmodule

//testbench

module tb;
  reg a,b,bin;
  wire diff,borrow;
  integer i;
  
  fsub f1(a,b,bin,diff,borrow);
  
  initial begin
    a=0;
    b=0;
    bin=0;
    $monitor("a=%b b=%b bin=%b difference=%b borrow=%b",a,b,bin,diff,borrow);
   
    #5;
    
    for(i=0;i<8;i++)begin
      {a,b,bin}=i;
      #10;
    end
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
    
  
  
