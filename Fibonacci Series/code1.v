module febonacci (
  input wire clk,
  output reg [31:0] current,
  output reg [31:0] prev
);
  initial begin
    current = 1;
    prev = 0;
  end
  
  initial begin		
    repeat(8) @(posedge clk) begin
      current <= current + prev;
      prev<= current;
    end
  end
  
endmodule

// TESTBENCH
module tb;
  reg clk;
  wire [31:0] current, prev; 
  febonacci dut (.clk(clk), .current(current), .prev(prev));
   
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    $monitor("@ %0t, prev_value=%0d, current_value=%0d", $time,prev,current);
  end
  
  initial begin
    #200 $finish;
  end
endmodule


/*OUTPUT
# KERNEL: @ 0,, prev_value=0, current_value=1
# KERNEL: @ 5,, prev_value=1, current_value=1
# KERNEL: @ 15,, prev_value=1, current_value=2
# KERNEL: @ 25,, prev_value=2, current_value=3
# KERNEL: @ 35,, prev_value=3, current_value=5
# KERNEL: @ 45,, prev_value=5, current_value=8
# KERNEL: @ 55,, prev_value=8, current_value=13
# KERNEL: @ 65,, prev_value=13, current_value=21
# KERNEL: @ 75,, prev_value=21, current_value=34*/
