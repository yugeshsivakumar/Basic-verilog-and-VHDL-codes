//design

module enc(in,en,clk,out);
  input [7:0]in;
  input en,clk;
  output reg [2:0]out;
 
  always@(posedge clk ) begin
    
   if(en)
     casex(in)
      8'b00000001:out=3'b000;
      8'b0000001x:out=3'b001;
      8'b000001xx:out=3'b010;
      8'b00001xxx:out=3'b011;
      8'b0001xxxx:out=3'b100;
      8'b001xxxxx:out=3'b101;
      8'b01xxxxxx:out=3'b110;
      8'b1xxxxxxx:out=3'b111;
      default :out=3'bzzz;
      endcase
    else     
      out=3'bxxx;
        
  end
endmodule

 //testbench
 
 module tb;
  reg [7:0]in;
  reg en,clk;
  wire [2:0]out;
  integer i;
    
  enc e(.in(in),.en(en),.clk(clk),.out(out));
  initial begin 
    clk=0;
   forever #1  clk=~clk;
  end
  
  initial begin
      $monitor("Time=%0t  En=%b  IN=%b  Out=%b",$time,en,in,out);

    en=0;
    #5 en=1;
    #5;
    for(i=1;i<=8;i++)
      begin
       in=$random;
        #5;
      end
    #50 $finish;
    end
  initial begin
      $dumpfile("dump.vcd");
      $dumpvars();
  end
endmodule  
