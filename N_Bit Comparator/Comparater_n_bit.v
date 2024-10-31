// design

module Comparater_n_bit(a,b,l,e,h);
//parameter n=32;
input [32-1:0]a;
input [32-1:0]b;
output reg l=0,e=0,h=0;
always @(a,b)
begin
if(a>b)
begin
l=0;e=0;h=1;
end
else if(a<b)
begin
l=1;e=0;h=0;
end
else
begin
l=0;e=1;h=0;
end
end
endmodule

// testbench


module Comparter_n_bit_tb();
//parameter n=32;
reg [32-1:0]a;
reg [32-1:0]b;
wire l,e,h;
Comparater_n_bit DUT(a,b,l,e,h);
initial
begin
a=22;b=200;
#10 a=233;b=200;
#10 a=888;b=888;
#10 a=123;b=234;
end
initial
begin
$monitor($time, "A=%d B=%d L=%d E=%d H=%d",a,b,l,e,h);
end


endmodule

