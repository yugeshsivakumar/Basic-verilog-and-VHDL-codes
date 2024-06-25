//design

module ring_ctr (input clk,rstn,
                 output reg [3:0]out
  );    
  always@(posedge clk)
    begin
      if(rstn)
        out=4'b1000;
      else begin
        out=out>>1;
        if(out==0001)
         #1 out=1000;
      end
    end
endmodule
 
 
 //testbench
 
 module tb;
  reg clk;
  reg rstn;
  wire [3:0]out;
 
  ring_ctr   u0 (.clk (clk),
                .rstn (rstn),
                .out (out));
 
  initial begin
    clk=0;
  forever #1 clk = ~clk;
  end
 
  initial begin
    rstn=1;
    $monitor ("T=%0t rst=%b out=%b", $time,rstn,out);
    #4rstn=0;
    
    #10$finish;
  end
   initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
endmodule
