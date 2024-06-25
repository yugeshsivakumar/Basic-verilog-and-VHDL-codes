//design

module d_ff(in,clk,rst,q,qb);
  input in,clk,rst;
  output reg q,qb;
  
  always@(posedge clk)begin
     if(rst)
      q=0;
    else
      q=in;
       qb=~q;
 
  end
endmodule


//testbench

module tb;
  reg in,clk,rst;
  wire q,qb;
  integer i;
  
  d_ff e(.in(in),.clk(clk),.rst(rst),.q(q),.qb(qb));
  
  initial begin
    clk=0;
    forever #1clk=~clk;
  end
  
  initial begin
      $monitor("Time=%0t Reset=%b  In=%b Q=%b Qb=%b",$time,rst,in,q,qb);

    rst=1;
    #5rst=0;
    for(i=0;i<5;i++)begin
      in=$random;
      #5;
    end
    for(i=0;i<5;i++)begin
      in=$random;
      #5rst=1;
    end
    #50 $finish;
  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
endmodule
