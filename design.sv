// Code your design here
module halfadder(S, C, x, y);
  input x, y;
  output S, C;
  
  xor U1(S, x, y);
  and U2(C, x, y);
  
endmodule

module fulladder(S, C, x, y, cin);
  input x, y, cin;
  output S, C;
  
  wire S1, D1, D2;
  
  halfadder HA1(S1, D1, x, y);
  halfadder HA2(S, D2, S1, cin);
  or U3(C, D1, D2);
  
endmodule

module FourBitAdder(S, C4, A, B, Cin);
	input [3:0] A,B;
	input Cin;
	output [3:0] S;
	output C4;
	
	wire C1, C2, C3;
	
	fulladder FA1(S[0], C1, A[0], B[0], Cin);
	fulladder FA2(S[1], C2, A[1], B[1], C1);
	fulladder FA3(S[2], C3, A[2], B[2], C2);
	fulladder FA4(S[3], C4, A[3], B[3], C3);

endmodule

module FourBitAS(S, C, A, B, M);
	input [3:0] A,B;
	input M;
	output [3:0] S;
	output C;
	
	wire [3:0] X;
	
	xor U1(X[0], B[0], M);
	xor U2(X[1], B[1], M);
	xor U3(X[2], B[2], M);
	xor U4(X[3], B[3], M);

	FourBitAdder FBA1(S, C, A, X, M);

endmodule

module mux4x1(i0, i1, i2, i3, select, y);
  input [3:0] i0, i1, i2, i3;
  input [1:0] select;
  output [3:0] y;
  reg [3:0] y;
  
  always @ (i0 or i1 or i2 or i3 or select)
    case (select)
      2'b00: y = i0;
      2'b01: y = i1;
      2'b10: y = i2;
      2'b11: y = i3;
    endcase
endmodule

module Alu(A, B, operation, result);
  input [3:0] A, B;
  input [1:0] operation;
  output [3:0] result;
  
  wire [3:0] I0, I1, I2, I3;
  wire C;
  
  and U1(I2[3], A[3], B[3]);
  and U2(I2[2], A[2], B[2]);
  and U3(I2[1], A[1], B[1]);
  and U4(I2[0], A[0], B[0]);
  
  or U5(I3[3], A[3], B[3]);
  or U6(I3[2], A[2], B[2]);
  or U7(I3[1], A[1], B[1]);
  or U8(I3[0], A[0], B[0]);
  
  assign operation[0] = 0;
  
  FourBitAS FBAS1(I1, C, A, B, operation[0]);
  FourBitAS FBAS2(I0, C, A, B, operation[0]);
  
  mux4x1 M1(I0, I1, I2, I3, operation, result);
  
endmodule

