// design

module mux_81(i,s,y);
input [7:0]i;
input [2:0]s;
output reg y;
always@(*)
begin
case(s)
	3'b000:y=i[0];
	3'b001:y=i[1];
	3'b010:y=i[2];
	3'b011:y=i[3];
	3'b100:y=i[4];
	3'b101:y=i[5];
	3'b110:y=i[6];
	3'b111:y=i[7];
	default:y=1'bz;
endcase
end
endmodule

// testbench


module Mux81_tb();
reg [7:0]i;
reg [2:0]s;
wire y;
mux_81 uut(i,s,y);
integer j;
initial
begin
	for(j=0;j<256;j=j+1)
	begin
	{i,s}=j;
	#10;
	end
end
initial
begin
$monitor($time,"S=%d i=%d y=%d",s,i,y);
end 

endmodule

