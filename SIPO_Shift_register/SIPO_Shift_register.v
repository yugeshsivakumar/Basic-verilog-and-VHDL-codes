//design

module sipo(din,clk,rst,dout);
  input din;
  input rst,clk;
  output reg [3:0]dout;
  
  always@(posedge clk)begin
    if(rst)
      dout=0;
    else
      begin
        dout[3]=din;
        $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);
        dout[2]=din;
        $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);
        dout[1]=din;
        $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);
        dout[0]=din;
        $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);
      end
  end
endmodule
  
  
  //testbench
  
  module tb();
  reg clk,rst;
  reg din;
  wire [3:0]dout;
  
  sipo p1(din,clk,rst,dout);
  
  initial begin
    clk=0;
    forever #1clk=~clk;
  end
  
  initial begin
    rst=1;
    #5 rst=0;
    repeat(10) begin
      #1 din=$random;
      #1 din=0;
      #1 din=1;
    end
    
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
  
    
