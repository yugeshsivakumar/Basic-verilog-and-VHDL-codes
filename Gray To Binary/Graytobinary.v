// design

module Graytobinary(g,b);
input [3:0]g;
output [3:0]b;
assign b[3]=g[3];
assign b[2]=g[3]^g[2];
assign b[1]=g[3]^g[2]^g[1];
assign b[0]=g[3]^g[2]^g[1]^g[0];



endmodule

// testbench


module Graytobinary_tb();
reg [3:0]g;
wire [3:0]b;
integer i;
Graytobinary DUT(g,b);
initial
begin
	g=0;
	for(i=0;i<16;i=i+1)
	begin
		g=i;
	   #10;
	end
	$finish;
end
initial
begin
$monitor($time," Gray =%d Binary =%d",g,b);
end


endmodule

