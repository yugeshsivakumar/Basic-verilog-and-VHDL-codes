//design

module dec(rst,clk,count,ud);
  input rst,clk,ud;
  output reg [3:0]count;
  
  always@(posedge clk)begin
   
    if(rst)
      count=4'b0;
    
    else if(ud==1)begin
      count=count+1;
            if(count==4'b1111)      
              #1count=4'b0000;
    end
         
    else if(ud==0) begin             
    count=count-1;
      if(count==4'b0000)   
        #1count=4'b1111;
    end
                
            
  end
endmodule

//testbench

module tb;
  reg rst,clk,ud;
  wire[3:0]count;
  
  dec e(.rst(rst),.clk(clk),.count(count),.ud(ud));
   
  initial begin
    clk=0;
    forever #1clk=~clk;
   end
  
  initial begin
    $monitor("Time=%0t  rst=%b  count=%b",$time,rst,count);
    rst=1;
    #5rst=0;
    ud=1;
    #30ud=0;
    #31ud=1;
    #25ud=0;
    #10$finish;

  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
endmodule
