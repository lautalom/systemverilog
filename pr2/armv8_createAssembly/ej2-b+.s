	.text
	.org 0x0000
//adds sum(0...6) and stores in seventh position in memory
add x5, XZR,XZR	
add x9, XZR,XZR
	
a: stur x0, [x9]
	add x9, x9, x8
	add x5, x0, x5
	add x0, x0, x1
	sub x7, x7, x1
	cbz x7, b
	cbz xzr, a
	stur x5, [x9]
	
b: 	stur x5, [x9]
cbz XZR, b
