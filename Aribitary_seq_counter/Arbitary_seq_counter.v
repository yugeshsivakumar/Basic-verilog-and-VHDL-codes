//design

module seq(clk, rst, count);
  input clk, rst;
  output reg [3:0] count;
  reg [2:0] state;
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= 3'b001;
      count <= 4'b0000;
    end else begin
      case (state)
        3'b001: begin
          count <= 4'b0010;
          state <= 3'b010;
        end
        3'b010: begin
          count <= 4'b1001;
          state <= 3'b011;
        end
        3'b011: begin
          count <= 4'b0100;
          state <= 3'b100;
        end
        3'b100: begin
          count <= 4'b0001;
          state <= 3'b101;
        end
        3'b101: begin
          count <= 4'b0110;
          state <= 3'b110;
        end
        3'b110: begin
          count <= 4'b0011;
          state <= 3'b111;
        end
        3'b111: begin
          count <= 4'b1000;
          state <= 3'b001;
        end
        default: begin
          state <= 3'b001;
        end
      endcase
    end
  end
endmodule

// testbench

module tb;
  reg clk, rst;
  wire [3:0] count;
  
  seq uut (clk, rst, count);
  
  initial begin
    clk = 0;
    forever #1 clk = ~clk;
  end
  
  initial begin
    $monitor("Time = %0t  Count = %b", $time, count);
    rst = 1;
    #5 rst = 0;
    #50 $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
  end
endmodule

