// design

module EvenParity(A,B,C,out);
input A,B,C;
output reg out;
always@(A,B,C)
begin
	out=A^B^C;
end



endmodule


// testbench

module Even_Parity_tb();
reg A,B,C;
wire out;
EvenParity DUT(A,B,C,out);
integer i;
initial
begin
	for(i=0;i<8;i=i+1)
	begin
		{A,B,C}=i;
		#10;
	end
end
initial
begin
$monitor($time," A=%d B=%d C=%d out=%d",A,B,C,out);
end


endmodule