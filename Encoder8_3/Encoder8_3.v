// design 

module Encoder8_3(en,in,out);
input [7:0]in;
input en;
output reg [2:0]out;
always@(en or in)
begin
	if(en==1)
	begin
	case(in)
	8'b00000001:out=3'b000;
	8'b00000010:out=3'b001;
	8'b00000100:out=3'b010;
	8'b00001000:out=3'b011;
	8'b00010000:out=3'b100;
	8'b00100000:out=3'b101;
	8'b01000000:out=3'b110;
	8'b10000000:out=3'b111;
	default:out=3'b0;
	endcase
	end
	else
		out=3'b0;
end
endmodule

// testbench

module Encoder83_tb();
reg [7:0]in;
reg en;
wire [2:0]out;
Encoder8_3 DUT(en,in,out);
integer i;
initial
begin
en=0;
for(i=0;i<8;i=i+1)
begin
in=2**i;
#10;
end
en=1;
for(i=0;i<8;i=i+1)
begin
in=2**i;
#10;
end
end
initial
begin
$monitor($time," en=%d in=%d out=%d",en,in,out);
end
endmodule
