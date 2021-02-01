transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/sl2.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/mux2.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/adder.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/writeback.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/processor_arm.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/memory.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/decode.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/datapath.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/controller.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/aludec.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/signext.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/regfile.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/maindec.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/imem.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/flopr.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/fetch.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/execute.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master {C:/Users/lauta/Desktop/quartus/2posta/processor_arm-master/alu.sv}
vcom -2008 -work work {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/dmem.vhd}

vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules {C:/Users/lauta/Desktop/quartus/2posta/SingleCycleProcessorPatterson-Modules/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
