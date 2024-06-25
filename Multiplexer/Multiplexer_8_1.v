//design

module multi(input[7:0]din,
             input [2:0]sel,
             input en,
             output reg out);
  
  always@(din or sel)begin
    
  
    if(!en)begin
    
      out=1'bx;
  
    end
 
    else
    
      begin  
      
        case(sel)
          3'b000:out=din[0];
          3'b001:out=din[1];
          3'b010:out=din[2];
          3'b011:out=din[3];
          3'b100:out=din[4];
          3'b101:out=din[5];
          3'b110:out=din[6];
          3'b111:out=din[7];

          
          default :out=1'bz;
      
        endcase
    
      end
  
  end
  

endmodule

//testbench

module tb;
  reg [7:0]din;
  reg [2:0]sel;
  reg en;
  wire out;
  integer i;
  
  multi m4(.din(din),.sel(sel),.en(en),.out(out));
  
  initial begin
    $monitor("Enable=%b DataIn=%0b sel=%b Out=%0b",en,din,sel,out);

    
    en=0;
    #5 en=1;
    
    din=8'd10010011;
    for(i=0;i<8;i++)
      begin
        sel=i;
        #5;
      end
    #5en=0;
    #50$finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule

      
        

          
          
  
  
  
  
  
