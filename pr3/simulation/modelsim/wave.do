onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processor_tb/CLOCK_50
add wave -noupdate /processor_tb/reset
add wave -noupdate /processor_tb/DM_writeEnable
add wave -noupdate /processor_tb/ExtIRQ
add wave -noupdate /processor_tb/ExtIAck
add wave -noupdate /processor_tb/DM_writeData
add wave -noupdate /processor_tb/DM_addr
add wave -noupdate /processor_tb/dump
add wave -noupdate /processor_tb/CLOCK_50
add wave -noupdate /processor_tb/reset
add wave -noupdate /processor_tb/DM_writeEnable
add wave -noupdate /processor_tb/ExtIRQ
add wave -noupdate /processor_tb/ExtIAck
add wave -noupdate /processor_tb/DM_writeData
add wave -noupdate /processor_tb/DM_addr
add wave -noupdate /processor_tb/dump
add wave -noupdate -divider EXCEPTION
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/NextPC_F
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/imem_addr_F
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/PCBranch_EX
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/EStatus
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/IM_readData
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/Exc
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/ERet
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/clk
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/reset
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/EProc
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/ExcAck
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/readData3_E
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/ExcVector
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/PCBranch_EXP
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/esync_out
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/elrout
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/errout
add wave -noupdate /processor_tb/dut/dp/EXCEPTION/esrout
add wave -noupdate -divider CONTROLLER
add wave -noupdate /processor_tb/dut/c/instr
add wave -noupdate /processor_tb/dut/c/ExcAck
add wave -noupdate /processor_tb/dut/c/ExtIRQ
add wave -noupdate /processor_tb/dut/c/reset
add wave -noupdate /processor_tb/dut/c/AluControl
add wave -noupdate /processor_tb/dut/c/EStatus
add wave -noupdate /processor_tb/dut/c/AluSrc
add wave -noupdate /processor_tb/dut/c/reg2loc
add wave -noupdate /processor_tb/dut/c/regWrite
add wave -noupdate /processor_tb/dut/c/Branch
add wave -noupdate /processor_tb/dut/c/memtoReg
add wave -noupdate /processor_tb/dut/c/memRead
add wave -noupdate /processor_tb/dut/c/memWrite
add wave -noupdate /processor_tb/dut/c/ERet
add wave -noupdate /processor_tb/dut/c/Exc
add wave -noupdate /processor_tb/dut/c/ExtIAck
add wave -noupdate /processor_tb/dut/c/AluOp_s
add wave -noupdate /processor_tb/dut/c/ExcAux
add wave -noupdate /processor_tb/dut/c/EStatusAux
add wave -noupdate /processor_tb/dut/c/ALUSrcAux
add wave -noupdate /processor_tb/dut/c/ALUOpAux
add wave -noupdate /processor_tb/dut/c/NotAnInstr
add wave -noupdate /processor_tb/dut/c/Reg2LocAux
add wave -noupdate /processor_tb/dut/c/MemtoRegAux
add wave -noupdate /processor_tb/dut/c/RegWriteAux
add wave -noupdate /processor_tb/dut/c/MemReadAux
add wave -noupdate /processor_tb/dut/c/MemWriteAux
add wave -noupdate /processor_tb/dut/c/BranchAux
add wave -noupdate /processor_tb/dut/c/ERetAux
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 330
configure wave -valuecolwidth 137
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {674 ps}
