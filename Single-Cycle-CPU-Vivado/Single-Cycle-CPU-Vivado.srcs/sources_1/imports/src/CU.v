`timescale 1ns / 1ps
`include "Constants.v"

module CU(
  input [5:0] Opcode,
  input [5:0] Funct,
  input Zero,
  input Sign,
  output ALUSrcA,
  output reg ALUSrcB,
  output RegDst,
  output MemToReg,
  output ExtSel,
  output MemRead,
  output MemWrite,
  output reg RegWrite,
  output reg [1:0] PCSrc,
  output reg [2:0] ALUOp
);

  // ALUSrcA
  assign ALUSrcA = (Opcode == `OP_SLL && Funct == `FUNCT_SLL) ? `ALU_FROM_SA : `ALU_FROM_DATA;

  // ALUSrcB
  always@(*) begin
    case(Opcode)
      `OP_ADDI, `OP_LW, `OP_SW, `OP_ORI: ALUSrcB = `ALU_FROM_IMMD;
      default: ALUSrcB = `ALU_FROM_DATA;
    endcase
  end

  // MemToReg
  assign MemToReg = Opcode == `OP_LW ? `REG_FROM_DATAMEMORY : `REG_FROM_ALU;

  // MemRead
  assign MemRead = Opcode == `OP_LW ? 0 : 1;
  
  // MemWrite
  assign MemWrite = Opcode == `OP_SW ? 0 : 1;
  
  // RegWrite
  always@(*) begin
    case(Opcode)
      `OP_SW, `OP_BEQ, `OP_BNE, `OP_BGTZ, `OP_J, `OP_HALT: RegWrite = 0;
      default: RegWrite = 1;
    endcase
  end

  // RegDst
  assign RegDst = Opcode == `OP_LW || Opcode == `OP_ADDI || Opcode == `OP_ORI ? `REG_FROM_RT : `REG_FROM_RD;

  // ExtSel
  assign ExtSel = Opcode == `OP_ORI ? `EXT_ZERO : `EXT_SIGN;

  // PCSrc
  always@(*) begin
    case(Opcode)
      `OP_BEQ: PCSrc = Zero == 1 ? `PC_REL_JMP : `PC_NEXT_INS;
      `OP_BNE: PCSrc = Zero == 1 ? `PC_NEXT_INS : `PC_REL_JMP;
      `OP_BGTZ: PCSrc = Sign == 0 && Zero == 0 ? `PC_REL_JMP : `PC_NEXT_INS;
      `OP_J: PCSrc = `PC_ABS_JMP;
      `OP_HALT: PCSrc = `PC_HALT;
      default: PCSrc = `PC_NEXT_INS;
    endcase
  end

  // ALUOp
  always@(*) begin
    case(Opcode)
      `OP_R_DEV: begin
        case(Funct)
          `FUNCT_ADD: ALUOp = `ALU_ADD;
          `FUNCT_SUB: ALUOp = `ALU_SUB;
          `FUNCT_AND: ALUOp = `ALU_AND;
          `FUNCT_OR: ALUOp = `ALU_OR;
          `FUNCT_SLL: ALUOp = `ALU_SLL;
          `FUNCT_SLT: ALUOp = `ALU_CMPS;
          default: ALUOp = `ALU_ADD;
        endcase
      end
      `OP_ORI: ALUOp = `ALU_OR;
      `OP_BEQ, `OP_BNE, `OP_BGTZ: ALUOp = `ALU_SUB;
      default: ALUOp = `ALU_ADD;
    endcase
  end

endmodule