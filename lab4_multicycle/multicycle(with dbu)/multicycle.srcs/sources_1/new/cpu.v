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
    input clk,rst,
    //为dbu增加端口
    input run,
    input [7:0] m_rf_addr,  //dbu读地址
    output [31:0] m_data,rf_data,
    output [207:0] status
    );


    wire [31:0] pc_cur,pc_next,pc_jump; //pc
    wire [31:0] MEMdata; //取出的指令或者数据
    wire [31:0] MEM_addr;
    wire [5:0]  IR_op;    //op,传给control unit
    wire [4:0]  IR_rs,IR_rt;  //rs,rt   
    wire [15:0] IR_Imm;    //指令后16位
    wire [31:0] MDR_out;  //MDR输出数据
    wire [4:0] Reg_addr;  //寄存器堆写入地址
    wire [31:0] Reg_data;  //寄存器堆写入数据
    wire [31:0] Imm_signext,Imm_shift;  //符号拓展后的立即数,左移后的立即数
    wire [31:0] rdA,rdB;    //寄存器堆两端口输出数据
    wire [31:0] regA,regB;  //A,B寄存器端口读出数据
    wire [31:0] srcA,srcB,ALU_result; //ALU操作数,结果
    wire [2 :0] ALUm;   //ALU控制信号
    wire [31:0] ALUout;     //ALUOut寄存器输出
    wire ALUzero,PCwe;  //alu零输出标志，PC寄存器写使能
    /*下面为控制信号*/
    wire PCWriteCond,PCWrite,IorD,MemRead,MemWrite; //MemRead暂时不用
    wire MemtoReg,IRWrite,RegDst,RegWrite,ALUSrcA;
    wire [1:0] ALUSrcB,ALUOp,PCSource;	
    
    //以下代码供dbu使用
    wire clk_p; //修改时钟信号
    assign clk_p = clk&run;
    assign status = {pc_cur,{IR_op,IR_rs,IR_rt,IR_Imm},MDR_out,
    regA,regB,ALUout,PCSource,PCwe,IorD,MemWrite,IRWrite,RegDst,
    MemtoReg,RegWrite,ALUm,ALUSrcA,ALUSrcB,ALUzero};


    //data path
    assign PCwe = PCWrite|(PCWriteCond&ALUzero);
    pc PC(
        .clk			(clk_p			),
        .rst			(rst			),
        .we             (PCwe           ),
        .pc_in			(pc_next		),
        .pc_out			(pc_cur			)
    );  //PC

    MUX2to1 MEMaddr_addr(
        .m              (IorD           ),
        .d0             (pc_cur         ),
        .d1             (ALUout         ),
        .out            (MEM_addr       )
    );

    RAM Memory(
        .clk            (clk_p          ),
        .we             (MemWrite       ),
        .a              (MEM_addr[10:2] ),
        .d              (regB           ),
        .spo            (MEMdata        )
    );

    Instr_Reg IR(
        .clk            (clk_p          ),
        .IRWrite        (IRWrite        ),
        .d_in           (MEMdata        ),  //instr
        .d_out0         (IR_op          ),  //op
        .d_out1         (IR_rs          ),  //rs
        .d_out2         (IR_rt          ),  //rt
        .d_out3         (IR_Imm         )   //末16位
    );   //IR

    Register MDR(
        .clk            (clk_p          ),
        .d_in           (MEMdata        ),
        .d_out          (MDR_out        )
    );   //MDR

    MUX2to1 reg_a(
        .m				(RegDst			),
        .d0				(IR_rt      	),
        .d1				(IR_Imm[15:11]	),
        .out			(Reg_addr  		)
    );	//write rt or rd

    MUX2to1 reg_d(
        .m              (MemtoReg       ),
        .d0             (ALUout         ),
        .d1             (MDR_out        ),
        .out            (Reg_data       )
    );

    register_file Regs(
        .clk			(clk_p			), 
        .ra0			(IR_rs      	),
        .rd0			(rdA			),
        .ra1			(IR_rt      	),
        .rd1			(rdB			), 
        .we				(RegWrite		),
        .wa				(Reg_addr		),
        .wd				(Reg_data		)
    );	//register file

    Register A(
        .clk            (clk_p          ),
        .d_in           (rdA            ),
        .d_out          (regA           )
    );

    Register B(
        .clk            (clk_p          ),
        .d_in           (rdB            ),
        .d_out          (regB           )
    );

    MUX2to1 srcA_mux(
        .m              (ALUSrcA        ),
        .d0             (pc_cur         ),
        .d1             (regA           ),
        .out            (srcA           )
    );

    assign Imm_signext = {{16{IR_Imm[15]}},IR_Imm}; //sign extend
    assign Imm_shift = (Imm_signext<<2);    //shift left2
    MUX4to1 srcB_mux(
        .sel            (ALUSrcB        ),
        .d0             (regB           ),
        .d1             (32'd4          ),
        .d2             (Imm_signext    ),
        .d3             (Imm_shift      ),
        .d_out          (srcB           )
    );

    alu ALU(
        .a				(srcA			),
        .b				(srcB			),
        .m				(ALUm			),
        .y				(ALU_result		),
        .zf				(ALUzero		)
    );  //alu

    Register ALUOut(
        .clk            (clk_p          ),
        .d_in           (ALU_result     ),
        .d_out          (ALUout         )
    );

    
    assign pc_jump = {pc_cur[31:28],{{IR_rs,IR_rt,IR_Imm}<<2}};
    MUX4to1 pc_mux(
        .sel            (PCSource       ),
        .d0             (ALU_result     ),
        .d1             (ALUout         ),
        .d2             (pc_jump        ),
        .d3             (32'd0          ),
        .d_out          (pc_next        )
    );

    //FSM,Control Unit
    Control_Unit FSM(
        .clk            (clk_p          ),
        .rst            (rst            ),
        .op             (IR_op          ),
        .PCWriteCond    (PCWriteCond    ),
        .PCWrite        (PCWrite        ),
        .IorD           (IorD           ),
        .MemRead        (MemRead        ),
        .MemWrite       (MemWrite       ),
        .MemtoReg       (MemtoReg       ),
        .IRWrite        (IRWrite        ),
        .RegDst         (RegDst         ),
        .RegWrite       (RegWrite       ),
        .ALUSrcA        (ALUSrcA        ),
        .ALUSrcB        (ALUSrcB        ),
        .ALUOp          (ALUOp          ),
        .PCSource       (PCSource       )
    );

    ALU_Control alu_control(
        .ALUOp          (ALUOp          ),
        .funct          (IR_Imm[5:0]    ),
        .ALUm           (ALUm           )
    );
    

endmodule
