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
