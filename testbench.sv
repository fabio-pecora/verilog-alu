module test;
  reg [3:0] A, B;
  reg [1:0] operation;
  wire [3:0] result;
  
  Alu uut(A, B, operation, result);
  
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars(1, test);
      $monitor("(A, B, operation) = %d %d %d = result = %d", A, B, operation, result);
      
      operation = 0; A = 3; B = 2;
      #10 operation = 1;
      #10 operation = 2;
      #10 operation = 3;
      #10 $finish;
      
    end
endmodule

