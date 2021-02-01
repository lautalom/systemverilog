	.text
	.org 0x0000
	add x29, xzr, xzr
loop:	stur x0, [x29]
	add x0, x0, x1
	add x29, x29, x8
	sub x30, x27, x0
	cbz x30, end
	cbz xzr, loop
end:	cbz xzr, end
