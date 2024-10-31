// design 
module Alu(a,b,s,y);
input [3:0]a,b,s;
output reg [3:0]y;
always@(*)
begin
case(s)
	4'b0000:y=a+b;//Addition
	4'b0001:y=a-b;//Substraction
	4'b0010:y=a*b;//Multipiler
	4'b0011:y=a/b;//Division
	4'b0100:y=a%b;//Modulo
	4'b0101:y=~a;//not a
	4'b0110:y=!b;//not b
	4'b0111:y=a^b;//xor
	4'b1000:y=~(a|b);//nor
	4'b1001:y=~(a^b);//xnor
	4'b1010:y=a**b;//square
	4'b1011:y=a&b;//and
	4'b1100:y=a|b;//or
	4'b1101:y=a+1;//increment
	4'b1110:y=a-1;//decrement
	4'b1111:y=!(a&b);//nand
	default:y=4'bzzz;
endcase
end

endmodule

// testbench 
module Alu_tb();
reg [3:0]a,b,s;
wire [3:0]y;
Alu DUT(a,b,s,y);
integer i; 
initial
begin
a<=4'b1100;//12
b<=4'b0010;//2
for(i=0;i<16;i=i+1)
begin
	s=i;
	#10;
end
end
initial
begin
$monitor($time,"S=%d A=%d B=%d Output=%d",s,a,b,y);
end
endmodule


