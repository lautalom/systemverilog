.text
.org 0x0000
// set memory with values to test
// if you don't set any of the memory positions, the result will be 0
// it's a really hard bug to find
stur x0, [x0]
stur x1, [x0, #8]
stur x2, [x0, #16]
stur x3, [x0, #24]
stur x4, [x0, #32]
stur x5, [x0, #40]
// inititalize accumulator
add x30, xzr, xzr
sum:
ldur x2, [x0]
add x30, x30, x2
add x0, x0, x8
sub x6, x6, x1
cbz x6, write
cbz xzr, sum
write:
stur x30, [x0]
end:
cbz xzr, end
