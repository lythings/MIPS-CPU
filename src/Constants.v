// Just for developing
`define OP_R_DEV 6'b000000

// Op
`define OP_ADD 6'b000000
`define OP_ADDI 6'b001000
`define OP_AND 6'b000000
`define OP_BEQ 6'b000100
`define OP_BGTZ 6'b000111 
`define OP_BNE 6'b000101
`define OP_HALT 6'b111111
`define OP_J 6'b000010
`define OP_LW 6'b100011
`define OP_OR 6'b000000
`define OP_ORI 6'b001101
`define OP_SLL 6'b000000
`define OP_SLT 6'b000000
`define OP_SUB 6'b000000
`define OP_SW 6'b101011

`define FUNCT_ADD 6'b100000
`define FUNCT_SUB 6'b100011
`define FUNCT_AND 6'b100100
`define FUNCT_OR 6'b100101
`define FUNCT_SLL 6'b000000
`define FUNCT_SLT 6'b101010

// ALU
`define ALU_ADD 3'b000
`define ALU_AND 3'b010
`define ALU_CMPS 3'b101
`define ALU_CMPU 3'b100
`define ALU_FROM_DATA 1'b0
`define ALU_FROM_IMMD 1'b1
`define ALU_FROM_SA 1'b1
`define ALU_OR 3'b011
`define ALU_SLL 3'b110
`define ALU_SUB 3'b001

// PC
`define PC_ABS_JMP 2'b10
`define PC_HALT 2'b11
`define PC_NEXT_INS 2'b00
`define PC_REL_JMP 2'b01

// Reg
`define REG_FROM_RD 1'b1
`define REG_FROM_RT 1'b0

// Extend
`define EXT_SIGN 1'b1
`define EXT_ZERO 1'b0

// DB
`define DB_FROM_ALU 1'b0
`define DB_FROM_DM 1'b1