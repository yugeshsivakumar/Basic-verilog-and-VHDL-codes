//design

module ha(input a,b,
          output sum,cout);
  assign sum=a^b;
  assign cout=a&b;
endmodule

module gen
  #(parameter N=4)
  (input[N-1:0]a,b,
   output[N-1:0]sum,cout);
  
   genvar i;
   
  generate
    for(i=0;i<N;i++)
      begin
        ha q1(a[i],b[i],sum[i],cout[i]);
      end
  endgenerate
endmodule
  
//testbench

module tb();
  parameter N=4;
  reg [N-1:0]a,b;
  wire [N-1:0]sum,cout;
  
  gen #(.N(N)) ws(.a(a),.b(b),.sum(sum),.cout(cout));
  
  initial begin
     a <= 0;
    b <= 0;
 
    $monitor("%0t  a=%0h b=%0h sum=%0h cout=%0h", $time,a, b, sum, cout);
 
    #10 a <=2;
        b <= 3;
    #20 b <= 4;
    #10 a <= 5;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
 
  
  
