//design

module ha(input a,b,
          output sum,cout);
  assign sum=a^b;
  assign cout=a&b;
endmodule

module fa(input a,b,cin, 
          output sum,cout);
  wire s1,s2,s3;
  ha h1(.a(a),.b(b),.sum(s1),.cout(s2));
  ha ha2(.a(s1),.b(cin),.sum(sum),.cout(s3));
        
    assign cout=s2|s3;
        
endmodule
         
//testbench

module tb;
  reg a,b,cin;
  wire sum,cout;
  integer i;
  fa fa1(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
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
         
