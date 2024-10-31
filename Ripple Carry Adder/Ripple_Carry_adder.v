// design

module Ripple_Carry_adder(A,B,Sum,Carry);
input [3:0]A,B;
output  [3:0]Sum;
output  Carry;
wire x,y,z;
full_add fa1(A[0],B[0],0,Sum[0],x);
full_add fa2(A[1],B[1],x,Sum[1],y);
full_add fa3(A[2],B[2],y,Sum[2],z);
full_add fa4(A[3],B[3],z,Sum[3],Carry);
endmodule

// testbench


module Ripple_carry_adder_tb();
reg [3:0]A_tb;
reg [3:0]B_tb;
wire carry_tb;
wire [3:0]Sum_tb;
Ripple_Carry_adder DUT(A_tb,B_tb,Sum_tb,carry_tb);
integer i;
initial
begin
	for(i=0;i<64;i=i+1)
	begin
		{A_tb,B_tb}=i;
		#10;
	end
end
initial
begin
$monitor($time,"A=%d \t B=%d \t Sum=%d \t Carry=%d\t ",A_tb,B_tb,Sum_tb,carry_tb );
end
endmodule
