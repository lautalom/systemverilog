onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processor_tb/CLOCK_50
add wave -noupdate /processor_tb/reset
add wave -noupdate /processor_tb/DM_writeEnable
add wave -noupdate /processor_tb/DM_writeData
add wave -noupdate /processor_tb/DM_addr
add wave -noupdate /processor_tb/dump
add wave -noupdate /processor_tb/CLOCK_50
add wave -noupdate /processor_tb/reset
add wave -noupdate /processor_tb/DM_writeEnable
add wave -noupdate /processor_tb/DM_writeData
add wave -noupdate /processor_tb/DM_addr
add wave -noupdate /processor_tb/dump
add wave -noupdate /processor_tb/CLOCK_50
add wave -noupdate /processor_tb/reset
add wave -noupdate /processor_tb/DM_writeEnable
add wave -noupdate /processor_tb/DM_writeData
add wave -noupdate /processor_tb/DM_addr
add wave -noupdate /processor_tb/dump
add wave -noupdate /processor_tb/CLOCK_50
add wave -noupdate /processor_tb/reset
add wave -noupdate /processor_tb/DM_writeEnable
add wave -noupdate /processor_tb/DM_writeData
add wave -noupdate /processor_tb/DM_addr
add wave -noupdate /processor_tb/dump
add wave -noupdate -divider {Instr Mem}
add wave -noupdate -radix decimal /processor_tb/dut/instrMem/addr
add wave -noupdate -divider datapath
add wave -noupdate -radix hexadecimal /processor_tb/dut/dp/IM_readData
add wave -noupdate -divider registros
add wave -noupdate -radix unsigned /processor_tb/dut/dp/DECODE/registers/ra1
add wave -noupdate -radix unsigned /processor_tb/dut/dp/DECODE/registers/ra2
add wave -noupdate -radix unsigned /processor_tb/dut/dp/DECODE/registers/rd1
add wave -noupdate -radix unsigned /processor_tb/dut/dp/DECODE/registers/rd2
add wave -noupdate -radix unsigned /processor_tb/dut/dp/DECODE/registers/wa3
add wave -noupdate -radix unsigned /processor_tb/dut/dp/DECODE/registers/wd3
add wave -noupdate -radix unsigned /processor_tb/dut/dp/DECODE/registers/we3
add wave -noupdate -divider Execute
add wave -noupdate -radix decimal /processor_tb/dut/dp/EXECUTE/readData1_E
add wave -noupdate -radix decimal /processor_tb/dut/dp/EXECUTE/readData2_E
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {421 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 284
configure wave -valuecolwidth 72
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
WaveRestoreZoom {413 ps} {508 ps}
