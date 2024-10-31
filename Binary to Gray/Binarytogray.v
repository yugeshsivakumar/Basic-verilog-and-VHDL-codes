// design

module Binarytogray(b,g);
input [3:0]b;
output [3:0]g;
assign g[3]=b[3];
assign g[2]=b[3]^b[2];
assign g[1]=b[2]^b[1];
assign g[0]=b[1]^b[0];
endmodule

// testbench

module Binarytogray_tb();
reg [3:0]b;
wire [3:0]g;
integer i;
Binarytogray DUT(b,g);
initial
begin
b=0;
for(i=0;i<16;i=i+1)
begin
	b=i;
	#10;
end
end
initial 
begin
$monitor($time," Binary=%d Gray=%d ",b,g);
end
endmodule