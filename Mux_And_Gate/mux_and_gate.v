// design

module mux_and_gate(A,B,y);
input A,B;
output y;
assign y=A?B:0;

endmodule

// testbench


module Mux_and_Gate_tb();
reg a,b;
wire y;

mux_and_gate DUT(a,b,y);
integer i;
initial
begin
for(i=0;i<4;i=i+1)
begin
{a,b}=i;
#10;
end
end
/*
begin
a=1'b0;b=1'b0;
#100 a=1'b1;b=1'b0;
#100 a=1'b0;b=1'b1;
#100 a=1'b1;b=1'b1;
end*/
initial 
begin
$monitor($time,"a=%b b=%d y=%d",a,b,y);
end

endmodule

