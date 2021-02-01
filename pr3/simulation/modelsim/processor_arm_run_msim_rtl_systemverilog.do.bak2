transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/exception.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/comp_n.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/writeback.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/sl2.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/signext.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/regfile.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/processor_arm.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/mux4.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/mux2.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/memory.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/maindec.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/imem.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/flopr_e.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/flopr.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/fetch.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/execute.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/decode.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/datapath.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/controller.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/aludec.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/alu.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/adder.sv}
vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/esync.sv}
vcom -93 -work work {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/dmem.vhd}

vlog -sv -work work +incdir+C:/Users/lauta/Desktop/quartus/pr3/quartus-project {C:/Users/lauta/Desktop/quartus/pr3/quartus-project/processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
