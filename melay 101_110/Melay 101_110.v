// design

module melay(Data_in,Data_out,clk,rst);
input Data_in,clk,rst;
output reg Data_out;
reg[2:0]current_state,next_state;
Parameter
s0=3'b000,s1=3'b001,s11=3'b010,s110=3'b011,s10=3'b100,s101=3'b101;
always @ (posedge clk,posedge rst)
begin
	if(rst)
	current_state<=s0;
	else
	current_state<=next_state;
end
always @(Data_in,current_state)
begin
	case(current_state)
	s0:
		if(Data_in==0)
		next_state<=s0;
		else
		next_state<=s1;
	s1:
		if(Data_in==0)
		next_state<=s10;
		else
		next_state<=s11;
	s11:
		if(Data_in==0)
		next_state<=s110;
		else
		next_state<=s11;
	s110:
		if(Data_in==1)
		next_state<=s101;
		else
		next_state<=s0;
	s10:
		if(Data_in==1)
		next_state<=s101;
		else
		next_state<=s0;s101:
		if(Data_in==1)
		next_state<=s11;
		else
		next_state<=s10;
default:next_state<=s0;
endcase
end
always @(posedge clk)
begin
	case(current_state)
		s0:if(Data_in==1 || Data_in==0)
			Data_out<=0;
		s1:if(Data_in==1 || Data_in==0 )
			Data_out<=0;
		s11:
			if(Data_in==1)
			Data_out<=0;
			else
			Data_out<=1;
		s110:if(Data_in==1 || Data_in==0)
			Data_out<=0;
		s101:if(Data_in==1 || Data_in==0)
			Data_out<=0;
		s10:
			if(Data_in==1)
			Data_out<=1;
			else
				Data_out<=0;
default:Data_out<=0;
endcase
end
endmodule

// testbench

module melay_tb();
reg Data_in_tb,clk_tb,rst_tb;
wire Data_out_tb;
melay DUT(Data_in_tb,Data_out_tb,clk_tb,rst_tb);
always
begin
	clk_tb<=1;
	#10;
	clk_tb<=0;
	#10;
end
task initialize;
begin
	Data_in_tb<=0;
	rst_tb<=0;
end
endtask
task rst(input a);
begin
	@(negedge clk_tb)
	rst_tb<=1;
	@(negedge clk_tb)
	rst_tb<=0;
end
endtask
task Din(input b);
begin
	@(negedge clk_tb)
	Data_in_tb<=b;
end
endtask
initial
begin
	initialize;
	rst(1);
	Din(1);
	Din(0);
	Din(1);
	rst(0);
	Din(1);
	Din(1);
	Din(0);
end
endmodule
