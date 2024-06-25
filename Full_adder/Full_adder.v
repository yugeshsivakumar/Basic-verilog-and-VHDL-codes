//design

module fulladd(input a,b,cin,
               output reg sum,cout);
  always@(a,b,cin)begin
    sum=a^b^cin;
    cout=(a&b)|(b&cin)|(cin&a);
  end
endmodule

//testbench

module tb;
  reg a,b,cin;
  wire sum,cout;
  integer i;
  fulladd fa1(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
  initial begin
    a<=0;
    b<=0;
    cin<=0;
      $monitor("a=%b b=%b cin=%b sum=%b cout=%b",a,b,cin,sum,cout);
    for(i=0;i<8;i++)
      begin
        {a,b,cin}=i;
        #10;
      end
  
  end
    
   initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
    endmodule
    
