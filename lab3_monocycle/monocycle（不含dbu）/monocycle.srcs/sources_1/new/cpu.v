`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 01:08:24
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module cpu(
    input clk,rst
    );

    wire [31:0] pc_cur,pc_next,pc_plus4,pc_jump,pc_beq,pc_result;
    wire [31:0] instr; //当前指令
    wire [4:0] wa;  //寄存器堆写入地址
    wire [31:0] Imm_signext,Imm_shift;  //符号拓展后的立即数,左移后的立即数
    wire [31:0] reg_B; //寄存器堆端口2读出数据
    wire [31:0] srcA,srcB,ALU_result; //ALU操作数,结果,SrcA也寄存器堆端口1数据
    wire [31:0] mem_dout,result;  //DM输出,写回结果
    wire RegDst,Jump,Branch,MemtoReg,MemRead,MemWrite,ALUSrc,RegWrite;	//控制信号
    wire [2:0] ALUOp;
    wire PC_Branch,zero;


    //data path
    pc PC(
        .clk			(clk			),
        .rst			(rst			),
        .pc_in			(pc_next		),
        .pc_out			(pc_cur			)
    );  //PC
    ADD PCplus4(
        .a				(pc_cur			),
        .b				(32'd4			),
        .y				(pc_plus4		)
    );	//加法器实现pc+4
     assign pc_jump = {pc_plus4[31:28],instr[25:0],2'b00};	//j指令

    ROM IM(
        .a				(pc_cur[9:2]	),
        .spo			(instr			)
    );	//instr memory
    MUX2to1 reg_mux(
        .m				(RegDst			),
        .d0				(instr[20:16]	),
        .d1				(instr[15:11]	),
        .out			(wa				)
    );	//write rt or rd
    
    register_file Regs(
        .clk			(clk			), 
        .ra0			(instr[25:21]	),
        .rd0			(srcA			),
        .ra1			(instr[20:16]	),
        .rd1			(reg_B			), 
        .we				(RegWrite		),
        .wa				(wa				),
        .wd				(result			)
    );	//register file

    Control_Unit Control(
        .op				(instr[31:26]	),
        .RegDst			(RegDst			),
        .Jump			(Jump			),
        .Branch			(Branch			),
        .MemtoReg		(MemtoReg		),
        .MemRead		(MemRead		),	//未使用
        .MemWrite		(MemWrite		),
        .ALUSrc			(ALUSrc			),
        .RegWrite		(RegWrite		),
        .ALUOp			(ALUOp			)
    );	//control unit

    MUX2to1 srcB_mux(
        .m				(ALUSrc			),
        .d0				(reg_B			),
        .d1				(Imm_signext	),
        .out			(srcB			)
    );     //src
    alu ALU(
        .a				(srcA			),
        .b				(srcB			),
        .m				(ALUOp			),
        .y				(ALU_result		),
        .zf				(zero			)
    );  //alu
    
    assign Imm_signext = {{16{instr[15]}},instr[15:0]};	//sign extend
    assign Imm_shift = (Imm_signext<<2);    //shift left2
    
    ADD PC_beq(
        .a				(pc_plus4		),
        .b				(Imm_shift		),
        .y				(pc_beq			)
    );	//pc_beq or pc_plus4
    assign PC_Branch = zero&Branch;		//PC_Branch
    MUX2to1 beq_mux(
        .m				(PC_Branch		),
        .d0				(pc_plus4		),
        .d1				(pc_beq			),
        .out			(pc_result		)
    );
    MUX2to1 jump_mux(
        .m				(Jump			),
        .d0				(pc_result		),
        .d1				(pc_jump		),
        .out			(pc_next		)
    );

    RAM DM(
        .clk			(clk			),
        .we				(MemWrite		),
        .a				(ALU_result[9:2]),	//特别注意指令按字节寻址
        .d				(reg_B			),
        .spo			(mem_dout		)
    );
    MUX2to1 result_mux(
        .m				(MemtoReg		),
        .d0				(ALU_result		),
        .d1				(mem_dout		),
        .out			(result			)
    );

endmodule
/*
module cpu(
    input clk,rst
    );

    wire [31:0] pc_cur,pc_next,pc_plus4,pc_jump,pc_beq,pc_result;
    wire [31:0] instr; //当前指令
    wire [4:0] wa;  //寄存器堆写入地址
    wire [31:0] Imm_signext,Imm_shift;  //符号拓展后的立即数,左移后的立即数
    wire [31:0] reg_B; //寄存器堆端口2读出数据
    wire [31:0] srcA,srcB,ALU_result; //ALU操作数,结果
    wire [31:0] mem_dout,result;  //DM输出,写回结果
    wire RegDst,Jump,Branch,MemtoReg,MemWrite,ALUSrc,RegWrite;
    wire [2:0] ALUOp;
    wire PC_Branch,zero;


    //data path
    pc PC(clk,rst,pc_next,pc_cur);  //PC
    ADD PCplus4(pc_cur,32'd4,pc_plus4);
    assign pc_jump = {pc_plus4[31:28],instr[25:0],2'b00};

    ROM IM(.a(pc_cur[9:2]),.spo(instr));
    MUX2to1 reg_mux(RegDst,instr[20:16],instr[15:11],wa);
    register_file Regs   (
        .clk(clk), .ra0(instr[25:21]), .rd0(srcA),
        .ra1(instr[20:16]), .rd1(reg_B), 
        .we(RegWrite), .wa(wa), .wd(result)
    );

    Control_Unit Control(
        instr[31:26],RegDst,Jump,Branch,
        MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp
    );

    MUX2to1 srcB_mux(ALUSrc,reg_B,Imm_signext,srcB);     //src
    alu ALU(.a(srcA),.b(srcB),.m(ALUOp),.y(ALU_result),.zf(zero));  //alu
    assign Imm_signext = {{16{instr[15]}},instr[15:0]};
    assign Imm_shift = (Imm_signext<<2);    //shift left2
    ADD PC_beq(pc_plus4,Imm_shift,pc_beq);
    assign PC_Branch = zero&Branch;
    MUX2to1 beq_mux(PC_Branch,pc_plus4,pc_beq,pc_result);
    MUX2to1 jump_mux(Jump,pc_result,pc_jump,pc_next);

    RAM DM(.clk(clk),.we(MemWrite),.a(ALU_result[7:0]>>2),.d(reg_B),.spo(mem_dout));
    MUX2to1 result_mux(MemtoReg,ALU_result,mem_dout,result);






endmodule
*/