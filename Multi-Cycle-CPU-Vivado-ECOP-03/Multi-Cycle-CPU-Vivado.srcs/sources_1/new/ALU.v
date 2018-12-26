`timescale 1ns / 1ps

module ALU(
  input ALUSrcA,
  input ALUSrcB,
  input [31:0] ReadData1,
  input [31:0] ReadData2,
  input [4:0] sa,
  input [31:0] sze,
  input [2:0] ALUOp,
  output zero,
  output sign,
  output reg [31:0] result
);

  wire [31:0] A;
  wire [31:0] B;

  assign A[4:0] = ALUSrcA ? sa : ReadData1[4:0];
  assign A[31:5] = ALUSrcA ? 0 : ReadData1[31:5];
  assign B = ALUSrcB ? sze : ReadData2;
  assign zero = result == 0;
  assign sign = result[31];

  always @(*) begin
    case(ALUOp)
      3'b000: result = A + B;
      3'b001: result = A - B;
      3'b010: result = B << A;
      3'b011: result = A | B;
      3'b100: result = A & B;
      3'b101: result = (A < B) ? 1 : 0;
      3'b110: result = ((A < B && A[31] == B[31]) || (A[31] == 1 && B[31] == 0)) ? 1 : 0;
      3'b111: result = A ^ B;
    endcase
  end

endmodule
