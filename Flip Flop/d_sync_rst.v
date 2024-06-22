module d_ff(input clk, rst, d, output reg q, output qbar);   
  always @(posedge clk)                             //synchronous reset, rst signal wait for posedge clk to come to rst the ff 
    begin
      if (rst)
        q <= 0;
      else
        q <= d;
    end
assign qbar=~q;
endmodule

//TESTBENCH
module tb;
  reg clk, rst, d;
  wire q,qbar;
  
  d_ff dut(.clk(clk), .rst(rst), .d(d), .q(q), .qbar(qbar));
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    $monitor("time @%0t,rst=%0b,d=%0b, q=%0b, qbar=%0b",$time,rst,d,q,qbar);
  end
  
  initial begin
    rst=0; d=1;#10;
    rst=0; d=0;#10;
    rst=0; d=1;#10;
    rst=1; d=1;#5;
    rst=0; d=0;#10;
    rst=0; d=1;#10;                    
    rst=0; d=1;#10;
    
    #100 $finish;
  end
endmodule


/*OUTPUT
# KERNEL: time @0,rst=0,d=1, q=x, qbar=x
# KERNEL: time @5,rst=0,d=1, q=1, qbar=0
# KERNEL: time @10,rst=0,d=0, q=1, qbar=0                   // q!=d, bcz at that time posedge clk didnt come , so ff shows its prev store value
# KERNEL: time @15,rst=0,d=0, q=0, qbar=1
# KERNEL: time @20,rst=0,d=1, q=0, qbar=1
# KERNEL: time @25,rst=0,d=1, q=1, qbar=0
# KERNEL: time @30,rst=1,d=1, q=1, qbar=0                   // rst=1 , but q != 0, bcz rst sigle wait for posedge clk to come 
# KERNEL: time @35,rst=0,d=0, q=0, qbar=1
# KERNEL: time @45,rst=0,d=1, q=1, qbar=0
*/  
  
  
