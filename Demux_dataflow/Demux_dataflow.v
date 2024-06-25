//design

module demux(input in,
             input s1=0,s2=0,
             output [3:0]out);
 
  assign out[3]=s1?(s2?in:0):0;
  assign out[2]=s1?(s2?0:in):0;
  assign out[1]=s1?0:(s2?in:0);
  assign out[0]=s1?0:(s2?0:in);

endmodule
             
//testbench

module tb();
  reg in,s1,s2;
  wire [3:0]out;
  
  demux d1(.in(in),.s1(s1),.s2(s2),.out(out));
  
  initial begin
    $monitor("Time=%0t  in=%b  sel=%b%b  out=%b",$time,in,s1,s2,out);
    in<=0;s1=0;s2=0;
     in<=1;
	s1=0;s2=0;
    #2{s1,s2}=1;
    #2{s1,s2}=2;
    #2{s1,s2}=3;
    
  end
endmodule
    
