//design

module jk_ff(j,k,rst,clk, q,qb);
  input j,k;
  input clk,rst;
  output reg q,qb;
  always@(posedge clk)
    begin
      if(!rst)
        begin
          case({j,k}) 
      2'b00 : q=q;
      2'b01 : q=0; 
      2'b10 : q=1;
      2'b11 : q=~q;
    endcase
                qb=~q;

        end
  else 
    q<=0;
 
    end
  
  
endmodule

//testbench

module tb;
  reg j,k,rst,clk;
  wire q,qb;
  integer i;
  jk_ff f1(.j(j),.k(k),.rst(rst),.clk(clk),.q(q),.qb(qb));
  
  initial begin
    clk=0;
    forever #1clk=~clk;
  end
    
    initial begin
    rst=1;
    {j,k}=0;
    
    #5 rst=0;
      $monitor("time=%0t rst=%b J=%b K=%b q=%b qb=%b",$time,rst,j,k,q,qb);

    for(i=0;i<4;i++)begin
      {j,k}=i;
      #5;
    end
    #5;
      for(i=3;i>=0;i--)begin
      {j,k}=i;
      #5;
    end
    
   
    #25$finish;
  end
  initial begin
      $dumpfile("dump.vcd");
      $dumpvars();
  end
endmodule
    
      
