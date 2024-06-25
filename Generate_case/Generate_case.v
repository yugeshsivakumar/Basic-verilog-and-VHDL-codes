//design

module ha (input a, b,
           output reg sum, cout);
  always @ (a or b)
  {cout, sum} = a + b;
  
  initial
    $display ("Half adder instantiation");
endmodule

module fa (input a, b, cin,
           output reg sum, cout);
  always @ (a or b or cin)begin
  {cout, sum} = a + b + cin;
  end
  
    initial
      $display ("Full adder instantiation");
endmodule

module gen(input a, b, cin,
                 output sum, cout);
  parameter ADDER_TYPE = 1;
  
  generate
    case(ADDER_TYPE)
      0 : ha u0 (.a(a), .b(b), .sum(sum), .cout(cout));
      1 : fa u1 (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
    endcase
  endgenerate
endmodule

//testbench

module tb;
  reg a, b, cin;
  wire sum, cout;
  
  gen #(.ADDER_TYPE(0)) u0 (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
  
  initial begin
    a <= 0;
    b <= 0;
    cin <= 0;
    
    $monitor("a=%b b=%b cin=%b sum=%b cout=%b",a, b, cin,sum,cout);
    
    for (int i = 0; i < 5; i = i + 1) begin
      #10 a <= $random;
      b <= $random;
      cin <= $random;
    end
    
  end
  
endmodule
