//design

module sreg(rst,clk,count,ud);
  input rst,clk,ud;
  output reg [8:0]count;
  
  always@(posedge clk)begin
   
    if(rst)
      count=8'b10110010;
        
    else if(ud==1)begin
      count=count>>1;
           
    end
         
    else if(ud==0) begin
         count=count<<1;
              end
                
            
  end
endmodule

  //testbench
  
  module tb;
  reg rst,clk,ud;
  wire[8:0]count;
  
  sreg e(.rst(rst),.clk(clk),.count(count),.ud(ud));
   
  initial begin
    clk=0;
    forever #1clk=~clk;
   end
  
  initial begin
    $monitor("Time=%0t  rst=%b ud=%b count=%b",$time,rst,ud,count);
    rst=1;
    #5rst=0;   
    ud=1;
    #5ud=0;
    #14$finish;

  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
endmodule
