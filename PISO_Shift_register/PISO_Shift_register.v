//design

module piso(din,clk,rst,dout);
  input [3:0]din;
  input clk,rst;
  output reg dout;
  
  always@(posedge clk)
    begin
      if(rst)
        dout=0;
      else
        begin
          dout=din[3];
          $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);

          dout=din[2];
          $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);
          dout=din[1];
          $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);
          dout=din[0];
          $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);
        end
    end
endmodule
  
//testbench

module tb();
  reg clk,rst;
  reg [3:0]din;
  wire dout;
  
  piso p1(din,clk,rst,dout);
  
  initial begin
    clk=0;
    forever #1clk=~clk;
  end
  
  initial begin
    rst=1;
    #5 rst=0;
    repeat(10) 
      #1 din=$random;
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
  
    
