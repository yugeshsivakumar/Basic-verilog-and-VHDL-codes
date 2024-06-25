//design

module seq(clk,in,out,count);
  input clk;
  input [15:0]in;
  output reg out;
  output reg[2:0]count=0;
  reg [2:0]state=1;
  
  reg [3:0]b1=4'b1111;
  reg [3:0]b2=4'b1110;
  reg [3:0]b3=4'b1101;
  reg [3:0]b4=4'b1100;
  
  always@(posedge clk)
    begin
      case(state)
        0:
          begin
            b1=b1-4;b2=b2-4;b3=b3-4;b4=b4-4;
            state=1;
          end
        1:
          begin
              if (in[b1]==1)
               state=2;
            else begin
              state=6;
              out=0;
            end
          end    
        2:
          begin
            if (in[b2]==0)
              state=3;
            else state=6;
          end
        3:
          begin
            if (in[b3]==1)
              state=4;
            else begin
             state=6;
              out=0;
            end
          end
        4:
          begin
            if (in[b4]==1)begin
              state=5;
            end
            else begin
              state=6;
              out=0;
            end
          end
        5:
          begin
            out=1'b1;
            #1out=0;
              count=count+1;
               state=6;
            
          end
         6:
            begin 
               if(b4==0)
   			  #1 $finish;
              state=0;
            end
      endcase
    end

endmodule

//testbench

module tb;
  reg clk;
  reg[15:0]in;
  wire out;
  wire [2:0]count;
  
  seq e1(clk,in,out,count);
  
  initial begin
    clk=0;
    forever #1 clk=~clk;
  end
  
  initial begin
    $monitor("Time=%0t  out=%b count=%b",$time,out,count);
    in=16'b1011_1011_1100_1011;
   #100 $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
