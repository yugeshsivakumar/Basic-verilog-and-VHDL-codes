// design

module priorityEncoder83(en,in,out);
input [7:0]in;
input en;
output reg [2:0]out;
always@(en or in)
begin
	if(en==1)
	begin
	case(in)
	8'b00000001:out=3'b000;
	8'b0000001z:out=3'b001;
	8'b000001zz:out=3'b010;
	8'b00001zzz:out=3'b011;
	8'b0001zzzz:out=3'b100;
	8'b001zzzzz:out=3'b101;
	8'b01zzzzzz:out=3'b110;
	8'b1zzzzzzz:out=3'b111;
	default:out=3'b0;
	endcase
	end
	else
		out=3'b0;
end
endmodule

// testbench


module PriorityEncoder83_tb();
reg [7:0]in;
reg en;
wire [2:0]out;
priorityEncoder83 DUT(en,in,out);
	initial begin
		// Initialize Inputs
		en = 0;
 in=8'b00000001;
#10; in=8'b0000001x;
#10; in=8'b000001xx;
#10; in=8'b00001xxx;
#10; in=8'b0001xxxx;
#10; in=8'b001xxxxx;
#10; in=8'b01xxxxxx;
#10; in=8'b1xxxxxxx;
#10; en = 1;
 in=8'b00000001;
#10; in=8'b0000001z;
#10; in=8'b000001zz;
#10; in=8'b00001zzz;
#10; in=8'b0001zzzz;
#10; in=8'b001zzzzz;
#10; in=8'b01zzzzzz;
#10; in=8'b1zzzzzzz;
end
initial
begin
$monitor($time," en=%d in=%d out=%d",en,in,out);
end


endmodule
