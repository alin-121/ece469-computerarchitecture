onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CPUstim/clk
add wave -noupdate /CPUstim/reset
add wave -noupdate -expand -group Flags /CPUstim/dut/FinalZero
add wave -noupdate -expand -group Flags /CPUstim/dut/FinalNegative
add wave -noupdate -expand -group Flags /CPUstim/dut/FinalCarry_Out
add wave -noupdate -expand -group Flags /CPUstim/dut/FinalOverflow
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[21]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[20]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[19]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[18]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[17]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[16]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[15]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[14]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[13]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[12]}
add wave -noupdate -expand -group {Memory view} -radix unsigned {/CPUstim/dut/dutt/mem[11]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[10]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[9]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[8]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[7]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[6]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[5]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[4]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[3]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[2]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[1]}
add wave -noupdate -expand -group {Memory view} -radix decimal {/CPUstim/dut/dutt/mem[0]}
add wave -noupdate -expand -group Regflie -color Magenta -radix decimal -childformat {{{/CPUstim/dut/pai/regfile_view[31]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[30]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[29]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[28]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[27]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[26]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[25]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[24]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[23]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[22]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[21]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[20]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[19]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[18]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[17]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[16]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[15]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[14]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[13]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[12]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[11]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[10]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[9]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[8]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[7]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[6]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[5]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[4]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[3]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[2]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[1]} -radix decimal} {{/CPUstim/dut/pai/regfile_view[0]} -radix decimal}} -expand -subitemconfig {{/CPUstim/dut/pai/regfile_view[31]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[30]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[29]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[28]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[27]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[26]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[25]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[24]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[23]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[22]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[21]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[20]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[19]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[18]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[17]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[16]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[15]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[14]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[13]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[12]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[11]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[10]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[9]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[8]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[7]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[6]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[5]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[4]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[3]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[2]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[1]} {-color Magenta -height 15 -radix decimal} {/CPUstim/dut/pai/regfile_view[0]} {-color Magenta -height 15 -radix decimal}} /CPUstim/dut/pai/regfile_view
add wave -noupdate /CPUstim/dut/bet/RegWrite
add wave -noupdate -expand -group {Instruction and PC} -label {Program Counter} -radix decimal /CPUstim/dut/thecounter/out
add wave -noupdate -expand -group {Instruction and PC} -expand -group {Ins and Op} /CPUstim/dut/bruh/instruction
add wave -noupdate -expand -group {Instruction and PC} -expand -group {Ins and Op} /CPUstim/dut/bet/OpCode
add wave -noupdate -expand -group IF_ID -label IF_ID_ins /CPUstim/dut/ins/out
add wave -noupdate -expand -group ID_EX -label ID_EX_B -radix decimal /CPUstim/dut/ID_EX_B/out
add wave -noupdate -expand -group ID_EX -label ID_EX_A -radix decimal /CPUstim/dut/ID_EX_A/out
add wave -noupdate -expand -group ID_EX -label ID_EX_Rd -radix unsigned /CPUstim/dut/ID_EX_Rd/out
add wave -noupdate -expand -group ID_EX -label ID_EX_Link -radix decimal /CPUstim/dut/ID_EX_Rd/out
add wave -noupdate -expand -group ID_EX -label ID_EX_MEMtoReg -radix decimal /CPUstim/dut/ID_EX_Link/q
add wave -noupdate -expand -group ID_EX -label ID_EX_MemWrite -radix decimal /CPUstim/dut/ID_EX_MemWrite/q
add wave -noupdate -expand -group ID_EX -label ID_EX_MemRead -radix decimal /CPUstim/dut/ID_EX_MemRead/q
add wave -noupdate -expand -group ID_EX -label ID_EX_RegWrite -radix unsigned /CPUstim/dut/ID_EX_RegWrite/q
add wave -noupdate -expand -group ID_EX -label ID_EX_Rm -radix unsigned /CPUstim/dut/ID_EX_Rm/out
add wave -noupdate -expand -group ID_EX -label ID_EX_Rn -radix unsigned /CPUstim/dut/ID_EX_Rn/out
add wave -noupdate -expand -group ID_EX -label ID_EX_ALuOp -radix unsigned /CPUstim/dut/ID_EX_ALUOp/out
add wave -noupdate -expand -group ID_EX -label ID_EX_ADDI -radix decimal /CPUstim/dut/ID_EX_ADDIflag/q
add wave -noupdate -expand -group ID_EX -label ID_EX_ALUSrc -radix decimal /CPUstim/dut/ID_EX_ALUSrc/q
add wave -noupdate -expand -group ID_EX -label ID_EX_PC4 -radix unsigned /CPUstim/dut/ID_EX_PC4/out
add wave -noupdate -expand -group ID_EX -label ID_EX_Dataaddr9 -radix decimal /CPUstim/dut/ID_EX_DtAddr9/out
add wave -noupdate -expand -group ID_EX -label ID_EX_Imm12 -radix unsigned /CPUstim/dut/ID_EX_Imm12/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17343330 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 413
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {157500 ns}
