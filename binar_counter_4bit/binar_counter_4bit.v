//design

module bin(rst,clk,count);
  input rst,clk;
  output reg [3:0]count;
  
  always@(posedge clk)begin
   
    if(rst)
      count=4'b0;
    else
      count=count+1;
    if(count==4'b1111)
      count=4'b0000;
  end
endmodule


//testbench

module tb;
  reg rst,clk;
  wire[3:0]count;
  
  bin e(.rst(rst),.clk(clk),.count(count));
   
  initial begin
    clk=0;
    forever #1clk=~clk;
   end
  
  initial begin
    $monitor("Time=%0t  rst=%b  count=%b",$time,rst,count);
    rst=1;
    #5rst=0;
    #30$finish;

  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
endmodule
  
