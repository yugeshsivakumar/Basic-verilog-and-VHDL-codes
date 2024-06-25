//design

module pipo(din,clk,rst,dout);
  input [3:0]din;
  input rst,clk;
  output reg [3:0]dout;
  
  always@(posedge clk)begin
    if(rst)
      dout=0;
    else begin
      dout=din;
          $display("Time=%0t rst=%b din=%b dout=%b",$time,rst,din,dout);
    end

    
  end
endmodule

//testbench

module tb();
  reg clk,rst;
  reg [3:0]din;
  wire [3:0]dout;
  
  pipo p1(din,clk,rst,dout);
  
  initial begin
    clk=0;
    forever #1clk=~clk;
  end
  
  initial begin
    rst=1;
    #5 rst=0;
    repeat(40) 
      #1 din=$random;
    #50 $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
  
    
