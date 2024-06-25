//design

module srff(s,r,rst,clk, q);
  input s,r;
  input clk,rst;
  output reg q;
  always@(posedge clk)
    begin
      if(!rst)
        begin
          case({s,r}) 
      2'b00 : q=q;
      2'b01 : q=0; 
      2'b10 : q=1;
      2'b11 : q=1'bz;
    endcase
        end
  else
         q<=0;

      end
endmodule

//testbench

module tb;
  reg s,r;
  reg rst,clk;
  wire q;
  integer i;
  srff sr1(.s(s),.r(r),.rst(rst),.clk(clk),.q(q));
  initial begin
  clk=0;
  forever #1clk=~clk;
  end
  
  initial
    begin
      {s,r}<=0;rst<=1;
      $monitor("time=%0t rst=%b S=%b R=%b,q=%b",$time,rst,s,r,q);

    #4 rst<=0; 
      for(i=0;i<4;i++)
      begin
        {s,r}=i;
        #5;
      end
      #20 $finish;
             end
   
  initial begin
      $dumpfile("dump.vcd");
      $dumpvars();
  end
endmodule 
      
      
